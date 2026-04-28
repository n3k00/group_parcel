import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/parcel_repository_provider.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../parcel/presentation/providers/parcel_form_provider.dart';
import '../../../parcel/presentation/providers/town_list_provider.dart';
import '../providers/settings_provider.dart';

class FromTownSettingsScreen extends ConsumerWidget {
  const FromTownSettingsScreen({super.key});

  static const routeName = '/settings/from-town';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sourceTownsAsync = ref.watch(sourceTownListProvider);
    final defaultTownAsync = ref.watch(defaultSourceTownNameProvider);

    return AppScaffold(
      title: AppStrings.fromTownTitle,
      body: sourceTownsAsync.when(
        data: (sourceTowns) => defaultTownAsync.when(
          data: (defaultTownName) {
            final selectedTownName = defaultTownName ??
                (sourceTowns.isEmpty ? '' : sourceTowns.first.townName);

            if (sourceTowns.isEmpty) {
              return const AppErrorView(message: AppStrings.noSourceTowns);
            }

            return ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: sourceTowns.length,
              separatorBuilder: (_, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final town = sourceTowns[index];
                final isSelected = town.townName == selectedTownName;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  title: Text(town.townName),
                  subtitle: Text(town.cityCode ?? ''),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle_rounded)
                      : const Icon(Icons.radio_button_unchecked_rounded),
                  selected: isSelected,
                  onTap: () async {
                    final repository = await ref.read(
                      settingsRepositoryProvider.future,
                    );
                    await repository.saveDefaultSourceTownName(town.townName);
                    ref.invalidate(defaultSourceTownNameProvider);
                    ref.invalidate(parcelFormProvider);
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AppStrings.defaultFromTownUpdated),
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
        loading: AppLoading.new,
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}
