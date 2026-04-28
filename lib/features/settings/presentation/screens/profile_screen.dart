import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/app_setup_config.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/section_card.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/settings/profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountCodeController = TextEditingController();

  bool _didSeedControllers = false;

  @override
  void dispose() {
    _accountCodeController.dispose();
    super.dispose();
  }

  void _seedControllers(AppSetupConfig setup) {
    if (_didSeedControllers) {
      return;
    }
    _accountCodeController.text = setup.accountCode;
    _didSeedControllers = true;
  }

  Future<void> _save(AppSetupConfig currentSetup) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nextSetup = currentSetup.copyWith(
      accountCode: _accountCodeController.text.trim().toUpperCase(),
    );

    await ref.read(settingsSetupProvider.notifier).saveSetup(nextSetup);
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.profileSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final setupAsync = ref.watch(settingsSetupProvider);

    return AppScaffold(
      title: AppStrings.profileTitle,
      body: setupAsync.when(
        data: (setup) {
          _seedControllers(setup);

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              SectionCard(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _accountCodeController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: AppStrings.accountCodeLabel,
                          ),
                          validator: _accountCodeValidator,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: setupAsync.isLoading
                                ? null
                                : () => _save(setup),
                            child: const Text(AppStrings.saveChanges),
                          ),
                        ),
                      ],
                    ),
                  ),
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

  String? _accountCodeValidator(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }
}
