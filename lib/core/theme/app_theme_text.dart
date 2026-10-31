import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_tokens.dart';
import 'app_text_styles.dart';

abstract final class AppThemeText {
  static TextStyle style(
    double size,
    FontWeight weight, {
    Color color = AppColors.textPrimary,
  }) => TextStyle(
    fontFamily: AppTextStyles.fontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: AppThemeTokens.lineHeight,
  );

  static final TextTheme theme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    headlineLarge: AppTextStyles.headline,
    headlineMedium: AppTextStyles.headline,
    headlineSmall: AppTextStyles.headline,
    titleLarge: style(AppThemeTokens.fsTitleLg, FontWeight.w700),
    titleMedium: style(AppThemeTokens.fsTitleMd, FontWeight.w600),
    titleSmall: AppTextStyles.subtitle,
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.body,
    bodySmall: style(
      AppThemeTokens.fsCaption,
      FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    labelLarge: AppTextStyles.bodyStrong,
    labelMedium: AppTextStyles.bodyStrong,
    labelSmall: AppTextStyles.caption,
  );
}
