import 'package:flutter/material.dart';

/// Kora color palette, derived from the official logo.
/// Blue = primary actions / active states. Orange = energy / highlights.
abstract final class AppColors {
  // Brand: blue
  static const Color primary = Color(0xFF0A57B8);
  static const Color primaryLight = Color(0xFF0A7BE0);
  static const Color primaryDark = Color(0xFF003A85);
  static const Color primarySoft = Color(0xFFE6EFF8);
  static const Color primaryPressed = Color(0xFF084B9D);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Brand: orange
  static const Color accent = Color(0xFFF57C1F);
  static const Color accentLight = Color(0xFFFF9A2E);
  static const Color accentDark = Color(0xFFE8590C);
  static const Color accentText = Color(0xFF9A3412);
  static const Color accentSoft = Color(0xFFFEF0E4);
  static const Color onAccent = Color(0xFFFFFFFF);

  static const Color success = Color(0xFF12B76A);
  static const Color successSoft = Color(0xFFE7F8EF);
  static const Color successText = Color(0xFF067647);
  static const Color warning = Color(0xFFF79009);
  static const Color warningSoft = Color(0xFFFEF3E2);
  static const Color warningText = Color(0xFF93370D);
  static const Color error = Color(0xFFF04438);
  static const Color errorSoft = Color(0xFFFEECEB);
  static const Color errorText = Color(0xFFB42318);
  static const Color info = primarySoft;

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1EEE8);
  static const Color background = Color(0xFFF8F6F2);
  static const Color border = Color(0xFFECE7DF);
  static const Color divider = Color(0xFFF0ECE5);
  static const Color textPrimary = Color(0xFF101828);
  static const Color textSecondary = Color(0xFF475467);
  static const Color textTertiary = Color(0xFF667085);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Court accents
  static const Color courtTeal = Color(0xFF14B8A6);
  static const Color courtPurple = Color(0xFF8B5CF6);
  static const Color courtPink = Color(0xFFEC4899);
  static const Color courtAmber = Color(0xFFF59E0B);

  // Greys
  static const Color grey100 = Color(0xFFF1F5F9);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E1);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey700 = Color(0xFF334155);

  static const Color textDisabled = textTertiary;
}
