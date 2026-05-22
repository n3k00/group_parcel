import '../models/enums/sync_status.dart';
import '../remote/firestore_parcel_data_source.dart';
import 'parcel_repository.dart';

class SyncResult {
  const SyncResult({
    required this.isSuccess,
    required this.message,
    this.pushedCount = 0,
    this.pulledCount = 0,
    this.failedCount = 0,
  });

  final bool isSuccess;
  final String message;
  final int pushedCount;
  final int pulledCount;
  final int failedCount;
}

class SyncRepository {
  const SyncRepository(this._parcelRepository, this._remoteDataSource);

  final ParcelRepository _parcelRepository;
  final ParcelRemoteDataSource _remoteDataSource;

  Future<SyncResult> syncNow() async {
    var pushed = 0;
    var pulled = 0;

    try {
      final localPending = await _parcelRepository.getParcelsBySyncStatus([
        SyncStatus.pending,
        SyncStatus.failed,
      ]);

      for (final localParcel in localPending) {
        final remoteParcel = await _remoteDataSource.fetchParcel(
          localParcel.trackingId,
        );

        if (remoteParcel != null &&
            remoteParcel.updatedAt.isAfter(localParcel.updatedAt)) {
          await _parcelRepository.saveCloudParcel(
            remoteParcel,
            preserveImagePath: localParcel.parcelImagePath,
          );
          pulled += 1;
          continue;
        }

        await _remoteDataSource.upsertParcel(localParcel);
        await _parcelRepository.markParcelSynced(localParcel.trackingId);
        pushed += 1;
      }

      final remoteParcels = await _remoteDataSource.fetchAllParcels();
      for (final remoteParcel in remoteParcels) {
        final localParcel = await _parcelRepository.getParcelByTrackingId(
          remoteParcel.trackingId,
        );

        if (localParcel == null) {
          await _parcelRepository.saveCloudParcel(remoteParcel);
          pulled += 1;
          continue;
        }

        if (remoteParcel.updatedAt.isAfter(localParcel.updatedAt)) {
          await _parcelRepository.saveCloudParcel(
            remoteParcel,
            preserveImagePath: localParcel.parcelImagePath,
          );
          pulled += 1;
          continue;
        }

        if (localParcel.syncStatus != SyncStatus.synced ||
            localParcel.syncedAt == null) {
          await _parcelRepository.markParcelSynced(localParcel.trackingId);
        }
      }

      return SyncResult(
        isSuccess: true,
        pushedCount: pushed,
        pulledCount: pulled,
        message:
            'Sync completed. Uploaded $pushed and downloaded $pulled parcels.',
      );
    } catch (error) {
      final localPending = await _parcelRepository.getParcelsBySyncStatus([
        SyncStatus.pending,
      ]);
      for (final parcel in localPending) {
        await _parcelRepository.markParcelSyncFailed(parcel.trackingId);
      }

      return SyncResult(
        isSuccess: false,
        pushedCount: pushed,
        pulledCount: pulled,
        failedCount: localPending.length,
        message:
            'Sync failed. Check your internet connection and try again.\n$error',
      );
    }
  }
}
