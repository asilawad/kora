import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_text.dart';
import 'app_theme_tokens.dart';

abstract final class AppThemeControls {
  static RoundedRectangleBorder _shape(double radius, {BorderSide? side}) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: side ?? BorderSide.none,
      );

  static OutlineInputBorder _inputBorder(Color color, double width) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppThemeTokens.radiusMd),
        borderSide: BorderSide(color: color, width: width),
      );

  static final ElevatedButtonThemeData elevatedButton =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.grey200,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: const Size.fromHeight(AppThemeTokens.buttonHeight),
          elevation: AppThemeTokens.zeroElevation,
          shape: _shape(AppThemeTokens.radiusMd),
          textStyle: AppThemeText.style(
            AppThemeTokens.fsBody,
            FontWeight.w700,
          ),
        ),
      );

  static final OutlinedButtonThemeData outlinedButton =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppThemeTokens.buttonHeight),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppThemeTokens.borderWidth,
          ),
          shape: _shape(AppThemeTokens.radiusMd),
          textStyle: AppThemeText.style(
            AppThemeTokens.fsBody,
            FontWeight.w700,
          ),
        ),
      );

  static final TextButtonThemeData textButton = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: AppThemeText.style(
        AppThemeTokens.fsBodySm,
        FontWeight.w600,
      ),
    ),
  );

  static final InputDecorationTheme input = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppThemeTokens.inputPaddingH,
      vertical: AppThemeTokens.inputPaddingV,
    ),
    hintStyle: AppThemeText.style(
      AppThemeTokens.fsBodySm,
      FontWeight.w400,
      color: AppColors.textDisabled,
    ),
    errorStyle: AppThemeText.style(
      AppThemeTokens.fsCaption,
      FontWeight.w400,
      color: AppColors.error,
    ),
    border: _inputBorder(AppColors.border, AppThemeTokens.borderWidth),
    enabledBorder: _inputBorder(AppColors.border, AppThemeTokens.borderWidth),
    focusedBorder: _inputBorder(
      AppColors.primary,
      AppThemeTokens.focusedBorderWidth,
    ),
    errorBorder: _inputBorder(AppColors.error, AppThemeTokens.borderWidth),
    focusedErrorBorder: _inputBorder(
      AppColors.error,
      AppThemeTokens.focusedBorderWidth,
    ),
  );

  static final CardThemeData card = CardThemeData(
    color: AppColors.surface,
    elevation: AppThemeTokens.zeroElevation,
    margin: EdgeInsets.zero,
    shape: _shape(
      AppThemeTokens.radiusLg,
      side: const BorderSide(
        color: AppColors.border,
        width: AppThemeTokens.borderWidth,
      ),
    ),
  );

  static final ChipThemeData chip = ChipThemeData(
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.primary,
    labelStyle: AppThemeText.style(
      AppThemeTokens.fsBodySm,
      FontWeight.w600,
    ),
    secondaryLabelStyle: AppThemeText.style(
      AppThemeTokens.fsBodySm,
      FontWeight.w600,
      color: AppColors.onPrimary,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppThemeTokens.chipPaddingH,
    ),
    showCheckmark: false,
    shape: _shape(
      AppThemeTokens.radiusPill,
      side: const BorderSide(
        color: AppColors.border,
        width: AppThemeTokens.borderWidth,
      ),
    ),
  );

  static final BottomSheetThemeData bottomSheet = BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    modalBackgroundColor: AppColors.surface,
    showDragHandle: true,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppThemeTokens.radiusXl),
      ),
    ),
  );
}
