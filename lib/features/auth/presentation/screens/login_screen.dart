import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/auth_strings.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../providers/parcel_repository_provider.dart';
import '../../../parcel/presentation/screens/home_screen.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSubmitting = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _isSubmitting = true;
    });

    try {
      final user = await ref
          .read(authServiceProvider)
          .signInWithPhonePassword(
            phoneNumber: _phoneController.text,
            password: _passwordController.text,
          );
      final preferences = await ref.read(appPreferencesProvider.future);
      await preferences.setLoginPhoneNumber(user.phoneNumber);
      if (!mounted) {
        return;
      }

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(HomeScreen.routeName, (_) => false);
    } catch (error) {
      if (!mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Bad state: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AuthStrings.loginTitle, style: AppTextStyles.display),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      AuthStrings.loginSubtitle,
                      style: AppTextStyles.bodyMuted,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      enabled: !_isSubmitting,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9\s-]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: AuthStrings.phoneNumberLabel,
                        hintText: AuthStrings.phoneNumberHint,
                        prefixIcon: Icon(Icons.phone_android_outlined),
                      ),
                      validator: _validatePhoneNumber,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      enabled: !_isSubmitting,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: AuthStrings.passwordLabel,
                        hintText: AuthStrings.passwordHint,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: _isSubmitting
                              ? null
                              : () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(AuthStrings.signInAction),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) {
      return AuthStrings.missingPhoneNumber;
    }
    try {
      AuthService.normalizePhoneNumber(raw);
    } on StateError catch (error) {
      return error.message.toString();
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return AuthStrings.missingPassword;
    }
    return null;
  }
}
