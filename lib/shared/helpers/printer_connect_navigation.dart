import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/services/bluetooth_permission_service.dart';
import '../../features/printing/presentation/screens/printer_connect_screen.dart';

final bluetoothPermissionServiceProvider = Provider<BluetoothPermissionService>(
  (ref) {
    return const BluetoothPermissionService();
  },
);

Future<void> openPrinterConnectPage(BuildContext context, WidgetRef ref) async {
  final result = await ref
      .read(bluetoothPermissionServiceProvider)
      .ensurePrinterPermissions();

  if (!context.mounted) {
    return;
  }

  if (!result.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.message ??
              'Bluetooth permission is required before opening printer connect page.',
        ),
        action: result.requiresSettings
            ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
            : null,
      ),
    );
    return;
  }

  await Navigator.of(context).pushNamed(PrinterConnectScreen.routeName);
}
