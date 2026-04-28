import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../parcel/presentation/screens/home_screen.dart';
import '../../../printer/presentation/screens/printer_settings_screen.dart';
import '../providers/settings_provider.dart';
import 'from_town_settings_screen.dart';
import 'profile_screen.dart';
import 'receipt_settings_screen.dart';
import 'staff_account_info_screen.dart';
import 'backup_restore_screen.dart';
import 'to_town_settings_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.watch(settingsDataProvider);

    return AppScaffold(
      title: AppStrings.settingsTitle,
      drawer: const AppDrawer(currentRoute: SettingsScreen.routeName),
      canPop: false,
      onBackNavigation: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: settingsData.when(
        data: (data) {
          final appInfo = data.appInfo;

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: AppResponsive.centeredContentWidth(
                context,
                horizontalPadding: AppSpacing.md,
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.md,
                ),
                children: [
                  _SettingsListTile(
                    icon: Icons.person_outline_rounded,
                    title: AppStrings.profileTitle,
                    subtitle: AppStrings.profileSubtitle,
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.location_on_outlined,
                    title: AppStrings.fromTownTitle,
                    subtitle: AppStrings.fromTownSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(FromTownSettingsScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.edit_location_alt_outlined,
                    title: AppStrings.voucherHeaderTitle,
                    subtitle: AppStrings.voucherHeaderSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(StaffAccountInfoScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.receipt_long_outlined,
                    title: AppStrings.receiptSettingsTitle,
                    subtitle: AppStrings.receiptSettingsSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(ReceiptSettingsScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.add_location_alt_outlined,
                    title: AppStrings.toTownTitle,
                    subtitle: AppStrings.toTownSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(ToTownSettingsScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.print_outlined,
                    title: AppStrings.printerSettingsTitle,
                    subtitle: AppStrings.printerSettingsSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(PrinterSettingsScreen.routeName);
                    },
                  ),
                  const Divider(height: 1, indent: AppSpacing.xl),
                  _SettingsListTile(
                    icon: Icons.backup_outlined,
                    title: AppStrings.backupRestoreTitle,
                    subtitle: AppStrings.backupRestoreSubtitle,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(BackupRestoreScreen.routeName);
                    },
                  ),
                  _SettingsInfoTile(
                    icon: Icons.info_outline,
                    title: AppStrings.appVersionTitle,
                    subtitle:
                        '${appInfo.appName}\n${appInfo.versionLabel}\n${appInfo.packageName}',
                  ),
                ],
              ),
            ),
          );
        },
        loading: AppLoading.new,
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  const _SettingsListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      minLeadingWidth: 28,
      horizontalTitleGap: AppSpacing.sm,
      leading: Icon(icon),
      title: Text(title, style: AppTextStyles.label),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(subtitle, style: AppTextStyles.bodyMuted),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class _SettingsInfoTile extends StatelessWidget {
  const _SettingsInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      minLeadingWidth: 28,
      horizontalTitleGap: AppSpacing.sm,
      leading: Icon(icon),
      title: Text(title, style: AppTextStyles.label),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(subtitle, style: AppTextStyles.bodyMuted),
      ),
    );
  }
}
