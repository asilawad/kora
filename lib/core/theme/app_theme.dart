import 'package:flutter/material.dart';

import 'app_colors.dart';

/// File-private design tokens (to be migrated to AppDimens later).
abstract final class _Tokens {
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusPill = 100;

  static const double buttonHeight = 52;
  static const double navBarHeight = 68;
  static const double borderWidth = 1;
  static const double focusedBorderWidth = 1.5;
  static const double zeroElevation = 0;

  static const double inputPaddingH = 16;
  static const double inputPaddingV = 14;
  static const double chipPaddingH = 8;

  static const double fsHeadline = 26;
  static const double fsTitleLg = 20;
  static const double fsTitleMd = 17;
  static const double fsBody = 15;
  static const double fsBodySm = 14;
  static const double fsCaption = 12;
  static const double lineHeight = 1.45;
}

/// Light theme for Kora. RTL comes from the Arabic locale set on
/// MaterialApp (via gen-l10n), so widgets must use Directional APIs.
abstract final class AppTheme {
  static const String fontFamily = 'Cairo';

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: fontFamily,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonTheme,
    inputDecorationTheme: _inputTheme,
    cardTheme: _cardTheme,
    chipTheme: _chipTheme,
    bottomSheetTheme: _bottomSheetTheme,
    navigationBarTheme: _navBarTheme,
    dialogTheme: _dialogTheme,
    snackBarTheme: _snackBarTheme,
    dividerTheme: _dividerTheme,
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

  static TextStyle _style(
    double size,
    FontWeight weight, {
    Color color = AppColors.textPrimary,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: _Tokens.lineHeight,
  );

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: _style(_Tokens.fsHeadline, FontWeight.w700),
    titleLarge: _style(_Tokens.fsTitleLg, FontWeight.w700),
    titleMedium: _style(_Tokens.fsTitleMd, FontWeight.w600),
    titleSmall: _style(_Tokens.fsBody, FontWeight.w600),
    bodyLarge: _style(_Tokens.fsBody, FontWeight.w400),
    bodyMedium: _style(_Tokens.fsBodySm, FontWeight.w400),
    bodySmall: _style(
      _Tokens.fsCaption,
      FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    labelLarge: _style(_Tokens.fsBody, FontWeight.w600),
    labelMedium: _style(_Tokens.fsBodySm, FontWeight.w600),
    labelSmall: _style(_Tokens.fsCaption, FontWeight.w600),
  );

  static RoundedRectangleBorder _shape(double radius, {BorderSide? side}) =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: side ?? BorderSide.none,
      );

  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: _Tokens.zeroElevation,
    scrolledUnderElevation: _Tokens.zeroElevation,
    centerTitle: true,
    titleTextStyle: _style(_Tokens.fsTitleMd, FontWeight.w700),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.grey200,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: const Size.fromHeight(_Tokens.buttonHeight),
          elevation: _Tokens.zeroElevation,
          shape: _shape(_Tokens.radiusMd),
          textStyle: _style(_Tokens.fsBody, FontWeight.w700),
        ),
      );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(_Tokens.buttonHeight),
          side: const BorderSide(
            color: AppColors.primary,
            width: _Tokens.borderWidth,
          ),
          shape: _shape(_Tokens.radiusMd),
          textStyle: _style(_Tokens.fsBody, FontWeight.w700),
        ),
      );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: _style(_Tokens.fsBodySm, FontWeight.w600),
    ),
  );

  static OutlineInputBorder _inputBorder(Color color, double width) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(_Tokens.radiusMd),
        borderSide: BorderSide(color: color, width: width),
      );

  static final InputDecorationTheme _inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: _Tokens.inputPaddingH,
      vertical: _Tokens.inputPaddingV,
    ),
    hintStyle: _style(
      _Tokens.fsBodySm,
      FontWeight.w400,
      color: AppColors.textDisabled,
    ),
    errorStyle: _style(
      _Tokens.fsCaption,
      FontWeight.w400,
      color: AppColors.error,
    ),
    border: _inputBorder(AppColors.border, _Tokens.borderWidth),
    enabledBorder: _inputBorder(AppColors.border, _Tokens.borderWidth),
    focusedBorder: _inputBorder(AppColors.primary, _Tokens.focusedBorderWidth),
    errorBorder: _inputBorder(AppColors.error, _Tokens.borderWidth),
    focusedErrorBorder: _inputBorder(
      AppColors.error,
      _Tokens.focusedBorderWidth,
    ),
  );

  static final CardThemeData _cardTheme = CardThemeData(
    color: AppColors.surface,
    elevation: _Tokens.zeroElevation,
    margin: EdgeInsets.zero,
    shape: _shape(
      _Tokens.radiusLg,
      side: const BorderSide(
        color: AppColors.border,
        width: _Tokens.borderWidth,
      ),
    ),
  );

  static final ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.primary,
    labelStyle: _style(_Tokens.fsBodySm, FontWeight.w600),
    secondaryLabelStyle: _style(
      _Tokens.fsBodySm,
      FontWeight.w600,
      color: AppColors.onPrimary,
    ),
    padding: const EdgeInsets.symmetric(horizontal: _Tokens.chipPaddingH),
    showCheckmark: false,
    shape: _shape(
      _Tokens.radiusPill,
      side: const BorderSide(
        color: AppColors.border,
        width: _Tokens.borderWidth,
      ),
    ),
  );

  static final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    modalBackgroundColor: AppColors.surface,
    showDragHandle: true,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(_Tokens.radiusXl),
      ),
    ),
  );

  static final NavigationBarThemeData _navBarTheme = NavigationBarThemeData(
    height: _Tokens.navBarHeight,
    backgroundColor: AppColors.surface,
    indicatorColor: AppColors.primarySoft,
    elevation: _Tokens.zeroElevation,
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => _style(
        _Tokens.fsCaption,
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

  static final DialogThemeData _dialogTheme = DialogThemeData(
    backgroundColor: AppColors.surface,
    elevation: _Tokens.zeroElevation,
    shape: _shape(_Tokens.radiusLg),
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.textPrimary,
    contentTextStyle: _style(
      _Tokens.fsBodySm,
      FontWeight.w500,
      color: AppColors.onPrimary,
    ),
    shape: _shape(_Tokens.radiusMd),
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.border,
    thickness: _Tokens.borderWidth,
    space: _Tokens.borderWidth,
  );
}
