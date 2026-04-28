import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/app_setup_config.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/section_card.dart';
import '../providers/settings_provider.dart';

class StaffAccountInfoScreen extends ConsumerStatefulWidget {
  const StaffAccountInfoScreen({super.key});

  static const routeName = '/settings/staff-account';

  @override
  ConsumerState<StaffAccountInfoScreen> createState() =>
      _StaffAccountInfoScreenState();
}

class _StaffAccountInfoScreenState
    extends ConsumerState<StaffAccountInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessSubtitleController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _businessPhoneController = TextEditingController();

  bool _didSeedControllers = false;

  @override
  void dispose() {
    _businessSubtitleController.dispose();
    _businessAddressController.dispose();
    _businessPhoneController.dispose();
    super.dispose();
  }

  void _seedControllers(AppSetupConfig setup) {
    if (_didSeedControllers) {
      return;
    }

    _businessSubtitleController.text = setup.businessSubtitle;
    _businessAddressController.text = setup.businessAddress;
    _businessPhoneController.text = setup.businessPhone;
    _didSeedControllers = true;
  }

  Future<void> _save(AppSetupConfig currentSetup) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nextSetup = currentSetup.copyWith(
      businessSubtitle: _businessSubtitleController.text.trim(),
      businessAddress: _businessAddressController.text.trim(),
      businessPhone: _businessPhoneController.text.trim(),
    );

    await ref.read(settingsSetupProvider.notifier).saveSetup(nextSetup);
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.voucherHeaderSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final setupAsync = ref.watch(settingsSetupProvider);

    return AppScaffold(
      title: AppStrings.voucherHeaderTitle,
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
                        Text(setup.businessName, style: AppTextStyles.title),
                        const SizedBox(height: AppSpacing.lg),
                        TextFormField(
                          controller: _businessSubtitleController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.subtitleLabel,
                          ),
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _businessAddressController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.addressLabel,
                          ),
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _businessPhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: AppStrings.phoneNumbersLabel,
                          ),
                          validator: _requiredValidator,
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

  String? _requiredValidator(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }
}
