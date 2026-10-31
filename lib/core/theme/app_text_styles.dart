import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_tokens.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Cairo';
  static const double bodyHeight = 1.55;

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsDisplay,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsHeadline,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsTitleLg,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsTitleMd,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsBody,
    height: bodyHeight,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsBodyStrong,
    height: bodyHeight,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsCaption,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  static const TextStyle price = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppThemeTokens.fsPrice,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
