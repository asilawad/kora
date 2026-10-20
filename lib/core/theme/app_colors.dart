import 'package:flutter/material.dart';

/// Kora color palette, derived from the official logo.
/// Blue = primary actions / active states. Orange = energy / highlights.
abstract final class AppColors {
  // Brand: blue
  static const Color primary = Color(0xFF0A57B8);
  static const Color primaryLight = Color(0xFF0A7BE0);
  static const Color primaryDark = Color(0xFF003A85);
  static const Color primarySoft = Color(0xFFE6F0FB);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Brand: orange
  static const Color accent = Color(0xFFF57C1F);
  static const Color accentLight = Color(0xFFFF9A2E);
  static const Color accentDark = Color(0xFFE8590C);
  static const Color accentSoft = Color(0xFFFFF0E3);
  static const Color onAccent = Color(0xFFFFFFFF);

  // Court accents
  static const Color courtTeal = Color(0xFF14B8A6);
  static const Color courtPurple = Color(0xFF8B5CF6);
  static const Color courtPink = Color(0xFFEC4899);
  static const Color courtAmber = Color(0xFFF59E0B);

  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color successSoft = Color(0xFFE6F6EC);
  static const Color error = Color(0xFFDC2626);
  static const Color errorSoft = Color(0xFFFDECEC);

  // Greys
  static const Color grey100 = Color(0xFFF1F5F9);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E1);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey700 = Color(0xFF334155);

  // Surfaces & text
  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = grey200;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = grey500;
  static const Color textDisabled = grey400;
}
