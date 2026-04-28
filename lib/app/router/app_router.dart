import 'package:flutter/material.dart';

import '../../features/parcel/presentation/screens/create_parcel_screen.dart';
import '../../features/parcel/presentation/screens/home_screen.dart';
import '../../features/parcel/presentation/screens/parcel_list_screen.dart';
import '../../features/printer/presentation/screens/printer_settings_screen.dart';
import '../../features/printing/presentation/screens/printer_connect_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/receipt_settings_screen.dart';
import '../../features/settings/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/staff_account_info_screen.dart';
import '../../features/settings/presentation/screens/from_town_settings_screen.dart';
import '../../features/settings/presentation/screens/to_town_settings_screen.dart';
import '../../features/settings/presentation/screens/backup_restore_screen.dart';
import '../../features/voucher/presentation/models/voucher_preview_args.dart';
import '../../features/voucher/presentation/screens/voucher_preview_screen.dart';
import '../../features/voucher/presentation/screens/voucher_reprint_preview_screen.dart';
import '../../shared/widgets/app_error_view.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case CreateParcelScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const CreateParcelScreen(),
          settings: settings,
        );
      case VoucherPreviewScreen.routeName:
        final args = settings.arguments;
        if (args is! VoucherPreviewArgs) {
          return _invalidRoute(
            settings: settings,
            message: 'Voucher preview requires valid preview arguments.',
          );
        }
        return MaterialPageRoute(
          builder: (_) => VoucherPreviewScreen(args: args),
          settings: settings,
        );
      case VoucherReprintPreviewScreen.routeName:
        final parcelId = settings.arguments;
        if (parcelId is! int || parcelId <= 0) {
          return _invalidRoute(
            settings: settings,
            message: 'Voucher reprint requires a valid parcel ID.',
          );
        }
        return MaterialPageRoute(
          builder: (_) => VoucherReprintPreviewScreen(parcelId: parcelId),
          settings: settings,
        );
      case PrinterConnectScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PrinterConnectScreen(),
          settings: settings,
        );
      case PrinterSettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PrinterSettingsScreen(),
          settings: settings,
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
      case StaffAccountInfoScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const StaffAccountInfoScreen(),
          settings: settings,
        );
      case ProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      case FromTownSettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const FromTownSettingsScreen(),
          settings: settings,
        );
      case ToTownSettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ToTownSettingsScreen(),
          settings: settings,
        );
      case BackupRestoreScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const BackupRestoreScreen(),
          settings: settings,
        );
      case ReceiptSettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ReceiptSettingsScreen(),
          settings: settings,
        );
      case ParcelListScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const ParcelListScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }

  static Route<dynamic> _invalidRoute({
    required RouteSettings settings,
    required String message,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Navigation Error')),
        body: AppErrorView(message: message),
      ),
    );
  }
}
