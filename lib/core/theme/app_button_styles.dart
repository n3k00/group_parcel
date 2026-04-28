import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppButtonStyles {
  const AppButtonStyles._();

  static final ButtonStyle primaryFilled = FilledButton.styleFrom(
    backgroundColor: AppColors.primaryButton,
    foregroundColor: AppColors.primaryButtonText,
    disabledBackgroundColor: AppColors.disabledButton,
    disabledForegroundColor: AppColors.disabledButtonText,
    elevation: 0,
    padding: AppSpacing.buttonPadding,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.medium),
    textStyle: AppTextStyles.button,
  );

  static final ButtonStyle secondaryFilled = FilledButton.styleFrom(
    backgroundColor: AppColors.secondaryButton,
    foregroundColor: AppColors.secondaryButtonText,
    disabledBackgroundColor: AppColors.disabledButton,
    disabledForegroundColor: AppColors.disabledButtonText,
    elevation: 0,
    padding: AppSpacing.buttonPadding,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.medium),
    textStyle: AppTextStyles.button,
  );

  static final ButtonStyle outlined = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.border),
    padding: AppSpacing.buttonPadding,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.medium),
    textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
  );

  static final ButtonStyle text = TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.medium),
    textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
  );

  static FilledButtonThemeData filledTheme() => FilledButtonThemeData(style: primaryFilled);
  static OutlinedButtonThemeData outlinedTheme() => OutlinedButtonThemeData(style: outlined);
  static TextButtonThemeData textTheme() => TextButtonThemeData(style: text);
}
