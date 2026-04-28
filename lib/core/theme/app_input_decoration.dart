import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppInputDecoration {
  const AppInputDecoration._();

  static InputDecorationTheme theme() {
    return const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      contentPadding: AppSpacing.inputContentPadding,
      hintStyle: AppTextStyles.bodyMuted,
      labelStyle: AppTextStyles.label,
      border: OutlineInputBorder(
        borderRadius: AppRadius.medium,
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.medium,
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.medium,
        borderSide: BorderSide(color: AppColors.focusedBorder, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.medium,
        borderSide: BorderSide(color: AppColors.inputErrorBorder),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.medium,
        borderSide: BorderSide(color: AppColors.inputErrorBorder, width: 1.5),
      ),
    );
  }

  static InputDecoration basic({
    required String label,
    required String hint,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
    );
  }
}
