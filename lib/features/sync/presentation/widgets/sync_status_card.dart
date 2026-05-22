import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/sync_provider.dart';

class SyncStatusCard extends ConsumerWidget {
  const SyncStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncProvider);

    String statusLabel() {
      switch (syncState.status) {
        case SyncRunStatus.idle:
          return AppStrings.syncIdleTitle;
        case SyncRunStatus.syncing:
          return AppStrings.syncInProgressTitle;
        case SyncRunStatus.synced:
          return AppStrings.syncSuccessTitle;
        case SyncRunStatus.failed:
          return AppStrings.syncFailedTitle;
      }
    }

    IconData statusIcon() {
      switch (syncState.status) {
        case SyncRunStatus.idle:
          return Icons.cloud_sync_outlined;
        case SyncRunStatus.syncing:
          return Icons.sync;
        case SyncRunStatus.synced:
          return Icons.cloud_done_outlined;
        case SyncRunStatus.failed:
          return Icons.cloud_off_outlined;
      }
    }

    Color statusColor() {
      switch (syncState.status) {
        case SyncRunStatus.idle:
          return AppColors.info;
        case SyncRunStatus.syncing:
          return AppColors.syncPending;
        case SyncRunStatus.synced:
          return AppColors.syncSynced;
        case SyncRunStatus.failed:
          return AppColors.syncFailed;
      }
    }

    final highlightColor = statusColor();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon(), color: highlightColor),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  AppStrings.syncSectionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: highlightColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(syncState.message),
            if (syncState.lastSyncedAt != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.syncLastRun(syncState.lastSyncedAt!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: syncState.isRunning
                  ? null
                  : () async {
                      final result = await ref
                          .read(syncProvider.notifier)
                          .syncNow();
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result.message)),
                      );
                    },
              icon: Icon(
                syncState.isRunning ? Icons.sync : Icons.cloud_sync_outlined,
              ),
              label: Text(
                syncState.isRunning
                    ? AppStrings.syncingAction
                    : AppStrings.syncNowAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
