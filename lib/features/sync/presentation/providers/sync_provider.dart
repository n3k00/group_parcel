import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../data/repositories/sync_repository.dart';
import '../../../../shared/providers/repository_provider.dart';

enum SyncRunStatus { idle, syncing, synced, failed }

class SyncViewState {
  const SyncViewState({
    this.status = SyncRunStatus.idle,
    this.message = AppStrings.syncIdleMessage,
    this.lastSyncedAt,
  });

  final SyncRunStatus status;
  final String message;
  final DateTime? lastSyncedAt;

  bool get isRunning => status == SyncRunStatus.syncing;

  SyncViewState copyWith({
    SyncRunStatus? status,
    String? message,
    DateTime? lastSyncedAt,
    bool clearLastSyncedAt = false,
  }) {
    return SyncViewState(
      status: status ?? this.status,
      message: message ?? this.message,
      lastSyncedAt: clearLastSyncedAt
          ? null
          : lastSyncedAt ?? this.lastSyncedAt,
    );
  }
}

class SyncNotifier extends Notifier<SyncViewState> {
  @override
  SyncViewState build() => const SyncViewState();

  Future<SyncResult> syncNow() async {
    if (state.isRunning) {
      return SyncResult(isSuccess: true, message: state.message);
    }

    state = state.copyWith(
      status: SyncRunStatus.syncing,
      message: AppStrings.syncInProgressMessage,
    );

    final result = await ref.read(syncRepositoryProvider).syncNow();
    final completedAt = DateTime.now();
    if (result.isSuccess) {
      final preferences = await ref.read(appPreferencesProvider.future);
      await preferences.setLastSuccessfulSyncAt(completedAt);
      ref.invalidate(hasCompletedInitialSyncProvider);
    }
    state = state.copyWith(
      status: result.isSuccess ? SyncRunStatus.synced : SyncRunStatus.failed,
      message: result.message,
      lastSyncedAt: result.isSuccess ? completedAt : state.lastSyncedAt,
    );
    return result;
  }
}

final syncProvider = NotifierProvider<SyncNotifier, SyncViewState>(
  SyncNotifier.new,
);

final hasCompletedInitialSyncProvider = FutureProvider<bool>((ref) async {
  final syncState = ref.watch(syncProvider);
  if (syncState.lastSyncedAt != null) {
    return true;
  }

  final preferences = await ref.watch(appPreferencesProvider.future);
  return preferences.getLastSuccessfulSyncAt() != null;
});
