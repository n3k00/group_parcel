import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class StoragePermissionResult {
  const StoragePermissionResult({
    required this.isGranted,
    this.message,
    this.requiresSettings = false,
  });

  final bool isGranted;
  final String? message;
  final bool requiresSettings;
}

class StoragePermissionService {
  const StoragePermissionService();

  Future<StoragePermissionResult> ensureBackupPermissions() async {
    if (!Platform.isAndroid) {
      return const StoragePermissionResult(isGranted: true);
    }

    final permissions = <Permission>[
      Permission.manageExternalStorage,
      Permission.storage,
    ];

    final currentStatuses = <Permission, PermissionStatus>{};
    for (final permission in permissions) {
      currentStatuses[permission] = await permission.status;
    }

    final grantedAlready = currentStatuses.values.any((status) => status.isGranted);
    if (grantedAlready) {
      return const StoragePermissionResult(isGranted: true);
    }

    final requestedStatuses = await permissions.request();
    final mergedStatuses = {...currentStatuses, ...requestedStatuses};
    final isGranted = mergedStatuses.values.any((status) => status.isGranted);
    if (isGranted) {
      return const StoragePermissionResult(isGranted: true);
    }

    final permanentlyDenied = mergedStatuses.values.any(
      (status) => status.isPermanentlyDenied || status.isRestricted,
    );

    return StoragePermissionResult(
      isGranted: false,
      requiresSettings: permanentlyDenied,
      message: permanentlyDenied
          ? 'Storage permission is blocked. Enable file access in Android settings first.'
          : 'Storage permission is required before creating a backup file.',
    );
  }
}
