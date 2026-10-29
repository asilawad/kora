import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_tokens.dart';

abstract final class AppThemeText {
  static TextStyle style(
    double size,
    FontWeight weight, {
    Color color = AppColors.textPrimary,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: AppThemeTokens.lineHeight,
  );

  static final TextTheme theme = TextTheme(
    headlineMedium: style(AppThemeTokens.fsHeadline, FontWeight.w700),
    titleLarge: style(AppThemeTokens.fsTitleLg, FontWeight.w700),
    titleMedium: style(AppThemeTokens.fsTitleMd, FontWeight.w600),
    titleSmall: style(AppThemeTokens.fsBody, FontWeight.w600),
    bodyLarge: style(AppThemeTokens.fsBody, FontWeight.w400),
    bodyMedium: style(AppThemeTokens.fsBodySm, FontWeight.w400),
    bodySmall: style(
      AppThemeTokens.fsCaption,
      FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    labelLarge: style(AppThemeTokens.fsBody, FontWeight.w600),
    labelMedium: style(AppThemeTokens.fsBodySm, FontWeight.w600),
    labelSmall: style(AppThemeTokens.fsCaption, FontWeight.w600),
  );
}
