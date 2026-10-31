import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_text.dart';
import 'app_theme_tokens.dart';

abstract final class AppThemeSurfaces {
  static final AppBarTheme appBar = AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.textPrimary,
    elevation: AppThemeTokens.zeroElevation,
    scrolledUnderElevation: AppThemeTokens.zeroElevation,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    actionsIconTheme: const IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: AppThemeText.style(
      AppThemeTokens.fsTitleMd,
      FontWeight.w700,
    ),
  );

  static final NavigationBarThemeData navigationBar = NavigationBarThemeData(
    height: AppThemeTokens.navBarHeight,
    backgroundColor: AppColors.surface,
    indicatorColor: AppColors.primarySoft,
    elevation: AppThemeTokens.zeroElevation,
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => AppThemeText.style(
        AppThemeTokens.fsCaption,
        FontWeight.w600,
        color: states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.textSecondary,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.textSecondary,
      ),
    ),
  );

  static final DialogThemeData dialog = DialogThemeData(
    backgroundColor: AppColors.surface,
    elevation: AppThemeTokens.zeroElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusLg),
    ),
  );

  static final SnackBarThemeData snackBar = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.textPrimary,
    contentTextStyle: AppThemeText.style(
      AppThemeTokens.fsBodySm,
      FontWeight.w500,
      color: AppColors.onPrimary,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusMd),
    ),
  );

  static const DividerThemeData divider = DividerThemeData(
    color: AppColors.divider,
    thickness: AppThemeTokens.borderWidth,
    space: AppThemeTokens.borderWidth,
  );
}
