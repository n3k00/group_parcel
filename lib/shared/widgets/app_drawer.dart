import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/auth_strings.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/parcel_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/parcel/presentation/screens/home_screen.dart';
import '../../features/parcel/presentation/screens/parcel_list_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.appName, style: AppTextStyles.title),
                  SizedBox(height: AppSpacing.xs),
                  Text(AppStrings.appTagline, style: AppTextStyles.bodyMuted),
                ],
              ),
            ),
            const Divider(height: 1),
            _DrawerItem(
              title: ParcelStrings.homeDrawerTitle,
              icon: Icons.home_outlined,
              selected: currentRoute == HomeScreen.routeName,
              onTap: () => _navigate(context, HomeScreen.routeName),
            ),
            _DrawerItem(
              title: ParcelStrings.parcelListTitle,
              icon: Icons.receipt_long_outlined,
              selected: currentRoute == ParcelListScreen.routeName,
              onTap: () => _navigate(context, ParcelListScreen.routeName),
            ),
            _DrawerItem(
              title: AppStrings.settingsTitle,
              icon: Icons.settings_outlined,
              selected: currentRoute == SettingsScreen.routeName,
              onTap: () => _navigate(context, SettingsScreen.routeName),
            ),
            const Spacer(),
            _DrawerItem(
              title: AuthStrings.logoutAction,
              icon: Icons.logout_rounded,
              selected: false,
              onTap: () => _logout(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String routeName) {
    Navigator.of(context).pop();
    if (currentRoute == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).pop();
    await ref.read(authServiceProvider).signOut();
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AuthStrings.loggedOutMessage)),
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginScreen.routeName,
      (_) => false,
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selected,
      onTap: onTap,
    );
  }
}
