import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/data/local/database/app_database.dart';
import 'package:group_mobile/data/models/enums/payment_status.dart';
import 'package:group_mobile/data/models/enums/parcel_status.dart';
import 'package:group_mobile/data/models/enums/sync_status.dart';
import 'package:group_mobile/data/models/parcel.dart';
import 'package:group_mobile/data/remote/firestore_parcel_data_source.dart';
import 'package:group_mobile/data/repositories/parcel_repository.dart';
import 'package:group_mobile/data/repositories/sync_repository.dart';

void main() {
  late AppDatabase database;
  late ParcelRepository parcelRepository;
  late FakeParcelRemoteDataSource remoteDataSource;
  late SyncRepository syncRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    parcelRepository = ParcelRepository(database.parcelsDao);
    remoteDataSource = FakeParcelRemoteDataSource();
    syncRepository = SyncRepository(parcelRepository, remoteDataSource);
  });

  tearDown(() async {
    await database.close();
  });

  test('pushes local pending parcels to the remote store', () async {
    await parcelRepository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250429-0001',
        syncStatus: SyncStatus.pending,
      ),
    );

    final result = await syncRepository.syncNow();
    final saved = await parcelRepository.getParcelByTrackingId(
      'TGI-A1-250429-0001',
    );

    expect(result.isSuccess, isTrue);
    expect(result.pushedCount, 1);
    expect(remoteDataSource.store.containsKey('TGI-A1-250429-0001'), isTrue);
    expect(saved, isNotNull);
    expect(saved!.syncStatus, SyncStatus.synced);
    expect(saved.syncedAt, isNotNull);
  });

  test('pulls newer remote parcels into the local database', () async {
    remoteDataSource.store['TGI-A1-250429-0002'] = _buildParcel(
      trackingId: 'TGI-A1-250429-0002',
      updatedAt: DateTime(2025, 4, 29, 12, 0),
      syncStatus: SyncStatus.synced,
    );

    final result = await syncRepository.syncNow();
    final local = await parcelRepository.getParcelByTrackingId(
      'TGI-A1-250429-0002',
    );

    expect(result.isSuccess, isTrue);
    expect(result.pulledCount, 1);
    expect(local, isNotNull);
    expect(local!.receiverName, 'Ma Su');
    expect(local.ledgerId, 'LEDGER-REMOTE');
    expect(local.syncStatus, SyncStatus.synced);
  });

  test('uses last write wins when the remote parcel is newer', () async {
    await parcelRepository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250429-0003',
        receiverName: 'Local Receiver',
        updatedAt: DateTime(2025, 4, 29, 9, 0),
        syncStatus: SyncStatus.pending,
      ),
    );
    remoteDataSource.store['TGI-A1-250429-0003'] = _buildParcel(
      trackingId: 'TGI-A1-250429-0003',
      receiverName: 'Remote Receiver',
      updatedAt: DateTime(2030, 4, 29, 10, 0),
      syncStatus: SyncStatus.synced,
    );

    final result = await syncRepository.syncNow();
    final local = await parcelRepository.getParcelByTrackingId(
      'TGI-A1-250429-0003',
    );

    expect(result.isSuccess, isTrue);
    expect(result.pulledCount, greaterThanOrEqualTo(1));
    expect(local, isNotNull);
    expect(local!.receiverName, 'Remote Receiver');
    expect(local.syncStatus, SyncStatus.synced);
  });

  test('marks failed syncs and retries them on the next run', () async {
    await parcelRepository.createParcel(
      _buildParcel(
        trackingId: 'TGI-A1-250429-0004',
        syncStatus: SyncStatus.pending,
      ),
    );
    remoteDataSource.throwOnUpsert = true;

    final failedResult = await syncRepository.syncNow();
    final failedLocal = await parcelRepository.getParcelByTrackingId(
      'TGI-A1-250429-0004',
    );

    expect(failedResult.isSuccess, isFalse);
    expect(failedLocal, isNotNull);
    expect(failedLocal!.syncStatus, SyncStatus.failed);

    remoteDataSource.throwOnUpsert = false;
    final retryResult = await syncRepository.syncNow();
    final retriedLocal = await parcelRepository.getParcelByTrackingId(
      'TGI-A1-250429-0004',
    );

    expect(retryResult.isSuccess, isTrue);
    expect(retryResult.pushedCount, 1);
    expect(remoteDataSource.store.containsKey('TGI-A1-250429-0004'), isTrue);
    expect(retriedLocal, isNotNull);
    expect(retriedLocal!.syncStatus, SyncStatus.synced);
  });
}

class FakeParcelRemoteDataSource implements ParcelRemoteDataSource {
  final Map<String, ParcelModel> store = {};
  bool throwOnUpsert = false;

  @override
  Future<ParcelModel?> fetchParcel(String trackingId) async {
    return store[trackingId];
  }

  @override
  Future<List<ParcelModel>> fetchAllParcels() async {
    return store.values.toList();
  }

  @override
  Future<void> upsertParcel(ParcelModel parcel) async {
    if (throwOnUpsert) {
      throw Exception('Remote unavailable');
    }
    store[parcel.trackingId] = parcel.copyWith(
      syncStatus: SyncStatus.synced,
      syncedAt: DateTime.now(),
    );
  }
}

ParcelModel _buildParcel({
  required String trackingId,
  String receiverName = 'Ma Su',
  DateTime? updatedAt,
  SyncStatus syncStatus = SyncStatus.pending,
}) {
  final timestamp = updatedAt ?? DateTime(2025, 4, 29, 9, 0);
  return ParcelModel(
    trackingId: trackingId,
    createdAt: DateTime(2025, 4, 29, 8, 0),
    fromTown: 'Taunggyi',
    toTown: 'Kalaw',
    cityCode: 'TGI',
    accountCode: 'A1',
    senderName: 'Ko Aung',
    senderPhone: '0912345678',
    receiverName: receiverName,
    receiverPhone: '0998765432',
    ledgerId: 'LEDGER-REMOTE',
    parcelType: 'Document',
    numberOfParcels: 1,
    totalCharges: 7000,
    paymentStatus: PaymentStatus.paid,
    cashAdvance: 0,
    remark: 'Handle carefully',
    status: ParcelStatus.received,
    syncStatus: syncStatus,
    syncedAt: syncStatus == SyncStatus.synced ? timestamp : null,
    updatedAt: timestamp,
  );
}
