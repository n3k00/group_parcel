import 'package:flutter/material.dart';

import 'app_button_styles.dart';
import 'app_colors.dart';
import 'app_input_decoration.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnSecondary,
      error: AppColors.error,
      onError: AppColors.textOnError,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      dividerColor: AppColors.divider,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.title,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        margin: EdgeInsets.zero,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.shadowLight,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.large,
          side: BorderSide(color: AppColors.border),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.sectionBackground,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.disabledButton,
        side: const BorderSide(color: Colors.transparent),
        padding: AppSpacing.chipPadding,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.roundedPill),
        labelStyle: AppTextStyles.label,
        secondaryLabelStyle: AppTextStyles.label,
      ),
      filledButtonTheme: AppButtonStyles.filledTheme(),
      outlinedButtonTheme: AppButtonStyles.outlinedTheme(),
      textButtonTheme: AppButtonStyles.textTheme(),
      inputDecorationTheme: AppInputDecoration.theme(),
    );
  }
}
