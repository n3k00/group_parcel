import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class BluetoothPermissionResult {
  const BluetoothPermissionResult({
    required this.isGranted,
    this.message,
    this.requiresSettings = false,
  });

  final bool isGranted;
  final String? message;
  final bool requiresSettings;
}

class BluetoothPermissionService {
  const BluetoothPermissionService();

  Future<BluetoothPermissionResult> ensurePrinterPermissions() async {
    if (!Platform.isAndroid) {
      return const BluetoothPermissionResult(isGranted: true);
    }

    final permissions = <Permission>[
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.locationWhenInUse,
    ];
    final currentStatuses = <Permission, PermissionStatus>{};
    for (final permission in permissions) {
      currentStatuses[permission] = await permission.status;
    }

    final missingPermissions = currentStatuses.entries
        .where((entry) => !entry.value.isGranted)
        .map((entry) => entry.key)
        .toList();

    if (missingPermissions.isEmpty) {
      return const BluetoothPermissionResult(isGranted: true);
    }

    final requestedStatuses = await missingPermissions.request();
    final mergedStatuses = {...currentStatuses, ...requestedStatuses};

    final allGranted = mergedStatuses.values.every(
      (status) => status.isGranted,
    );
    if (allGranted) {
      return const BluetoothPermissionResult(isGranted: true);
    }

    final permanentlyDenied = mergedStatuses.values.any(
      (status) => status.isPermanentlyDenied || status.isRestricted,
    );

    return BluetoothPermissionResult(
      isGranted: false,
      requiresSettings: permanentlyDenied,
      message: permanentlyDenied
          ? 'Bluetooth or location permission is blocked. Enable Nearby devices and Location permission in Android settings first.'
          : 'Bluetooth and location permission are required before opening printer connect page.',
    );
  }
}
