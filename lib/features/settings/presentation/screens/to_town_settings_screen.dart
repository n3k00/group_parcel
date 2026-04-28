import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../providers/town_settings_provider.dart';

class ToTownSettingsScreen extends ConsumerStatefulWidget {
  const ToTownSettingsScreen({super.key});

  static const routeName = '/settings/to-town';

  @override
  ConsumerState<ToTownSettingsScreen> createState() =>
      _ToTownSettingsScreenState();
}

class _ToTownSettingsScreenState extends ConsumerState<ToTownSettingsScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final townSettingsAsync = ref.watch(townSettingsProvider);

    ref.listen<AsyncValue<TownSettingsState>>(townSettingsProvider, (
      previous,
      next,
    ) {
      final message = next.asData?.value.errorMessage;
      if (message != null && message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return AppScaffold(
      title: AppStrings.toTownTitle,
      body: townSettingsAsync.when(
        data: (state) {
          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: AppStrings.newDestinationTownLabel,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: () async {
                      final value = _controller.text.trim();
                      if (value.isEmpty) {
                        return;
                      }
                      await ref
                          .read(townSettingsProvider.notifier)
                          .addDestinationTown(townName: value);
                      if (!mounted) {
                        return;
                      }
                      _controller.clear();
                    },
                    child: const Text(AppStrings.addAction),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ...state.destinationTowns.map(
                (town) => Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      title: Text(town.townName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: town.id == null
                            ? null
                            : () async {
                                final shouldDelete = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                          AppStrings.deleteToTownTitle,
                                        ),
                                        content: Text(
                                          'Remove "${town.townName}" from destination towns?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text(
                                              AppStrings.cancelAction,
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text(
                                              AppStrings.deleteAction,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ) ??
                                    false;

                                if (!shouldDelete) {
                                  return;
                                }

                                await ref
                                    .read(townSettingsProvider.notifier)
                                    .deleteTown(town.id!);
                              },
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ),
            ],
          );
        },
        loading: AppLoading.new,
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}
