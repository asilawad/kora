import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_controls.dart';
import 'app_theme_surfaces.dart';
import 'app_theme_text.dart';
import 'app_theme_tokens.dart';

abstract final class AppTheme {
  static const String fontFamily = 'Cairo';

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: fontFamily,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppThemeText.theme,
    appBarTheme: AppThemeSurfaces.appBar,
    elevatedButtonTheme: AppThemeControls.elevatedButton,
    filledButtonTheme: AppThemeControls.filledButton,
    outlinedButtonTheme: AppThemeControls.outlinedButton,
    textButtonTheme: AppThemeControls.textButton,
    inputDecorationTheme: AppThemeControls.input,
    cardTheme: AppThemeControls.card,
    chipTheme: AppThemeControls.chip,
    bottomSheetTheme: AppThemeControls.bottomSheet,
    navigationBarTheme: AppThemeSurfaces.navigationBar,
    dialogTheme: AppThemeSurfaces.dialog,
    snackBarTheme: AppThemeSurfaces.snackBar,
    dividerTheme: AppThemeSurfaces.divider,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    splashFactory: InkRipple.splashFactory,
    splashColor: AppColors.primary.withValues(
      alpha: AppThemeTokens.splashOpacity,
    ),
    highlightColor: AppColors.primary.withValues(
      alpha: AppThemeTokens.highlightOpacity,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  static const ColorScheme _colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primarySoft,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.accent,
    onSecondary: AppColors.onAccent,
    secondaryContainer: AppColors.accentSoft,
    onSecondaryContainer: AppColors.accentDark,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
    onError: AppColors.onPrimary,
    outline: AppColors.border,
  );
}
