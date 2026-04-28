import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../providers/parcel_repository_provider.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class PrinterSettingsScreen extends ConsumerWidget {
  const PrinterSettingsScreen({super.key});

  static const routeName = '/settings/printer';

  static const _presets = <_PrinterPresetOption>[
    _PrinterPresetOption(
      value: 'light',
      title: AppStrings.printerPresetLight,
      subtitle: AppStrings.printerPresetLightSubtitle,
    ),
    _PrinterPresetOption(
      value: 'balanced',
      title: AppStrings.printerPresetBalanced,
      subtitle: AppStrings.printerPresetBalancedSubtitle,
    ),
    _PrinterPresetOption(
      value: 'dark',
      title: AppStrings.printerPresetDark,
      subtitle: AppStrings.printerPresetDarkSubtitle,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presetAsync = ref.watch(printerPresetProvider);

    return AppScaffold(
      title: AppStrings.printerSettingsTitle,
      body: presetAsync.when(
        data: (selectedPreset) {
          return ListView.separated(
            padding: AppSpacing.screenPadding,
            itemCount: _presets.length,
            separatorBuilder: (_, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final preset = _presets[index];
              final isSelected = preset.value == selectedPreset;

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xs,
                ),
                title: Text(preset.title, style: AppTextStyles.label),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    preset.subtitle,
                    style: AppTextStyles.bodyMuted,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded)
                    : const Icon(Icons.radio_button_unchecked_rounded),
                onTap: () async {
                  final repository = await ref.read(
                    settingsRepositoryProvider.future,
                  );
                  await repository.savePrinterPreset(preset.value);
                  ref.invalidate(printerPresetProvider);
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${preset.title} preset selected.'),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: AppLoading.new,
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}

class _PrinterPresetOption {
  const _PrinterPresetOption({
    required this.value,
    required this.title,
    required this.subtitle,
  });

  final String value;
  final String title;
  final String subtitle;
}
