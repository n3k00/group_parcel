import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const primary = Color(0xFF0F4C81);
  static const primaryLight = Color(0xFF3B6A99);
  static const primaryDark = Color(0xFF0A355A);
  static const secondary = Color(0xFF2E8B57);
  static const secondaryLight = Color(0xFF5AA37A);
  static const secondaryDark = Color(0xFF1F6B43);
  static const accent = Color(0xFFD97706);
  static const accentLight = Color(0xFFE89A3A);
  static const accentDark = Color(0xFFA95A04);
  static const success = Color(0xFF2E8B57);
  static const warning = Color(0xFFD97706);
  static const error = Color(0xFFC62828);
  static const info = Color(0xFF2563EB);
  static const background = Color(0xFFF7F9FC);
  static const surface = Color(0xFFFFFFFF);
  static const card = Color(0xFFFFFFFF);
  static const sectionBackground = Color(0xFFEEF2F7);
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnSecondary = Color(0xFFFFFFFF);
  static const textOnError = Color(0xFFFFFFFF);
  static const border = Color(0xFFD1D5DB);
  static const divider = Color(0xFFE5E7EB);
  static const inputBorder = Color(0xFFC7CDD6);
  static const focusedBorder = Color(0xFF0F4C81);
  static const received = Color(0xFF2563EB);
  static const dispatched = Color(0xFFD97706);
  static const arrived = Color(0xFF2E8B57);
  static const claimed = Color(0xFF374151);
  static const syncPending = Color(0xFFD97706);
  static const syncSynced = Color(0xFF2E8B57);
  static const syncFailed = Color(0xFFC62828);
  static const paymentPaid = Color(0xFF2E8B57);
  static const paymentUnpaid = Color(0xFFC62828);
  static const primaryButton = primary;
  static const primaryButtonText = textOnPrimary;
  static const secondaryButton = secondary;
  static const secondaryButtonText = textOnSecondary;
  static const disabledButton = Color(0xFFCBD5E1);
  static const disabledButtonText = Color(0xFF6B7280);
  static const inputBackground = Color(0xFFFFFFFF);
  static const inputHint = Color(0xFF9CA3AF);
  static const inputText = Color(0xFF1F2937);
  static const inputLabel = Color(0xFF374151);
  static const inputErrorBorder = Color(0xFFC62828);
  static const snackbarSuccess = Color(0xFF1F6B43);
  static const snackbarError = Color(0xFFB91C1C);
  static const snackbarWarning = Color(0xFFB45309);
  static const snackbarInfo = Color(0xFF1D4ED8);
  static const iconPrimary = Color(0xFF0F4C81);
  static const iconSecondary = Color(0xFF6B7280);
  static const iconOnDark = Color(0xFFFFFFFF);
  static const shadowLight = Color(0x14000000);
  static const shadowMedium = Color(0x24000000);

  static const heroGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
