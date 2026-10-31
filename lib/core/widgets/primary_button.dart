import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme_tokens.dart';
import 'tap_scale.dart';
import 'widget_dimensions.dart';

final class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => TapScale(
    enabled: !isLoading && onPressed != null,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(AppThemeTokens.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeTokens.radiusMd),
        ),
        disabledBackgroundColor: AppColors.surfaceMuted,
        disabledForegroundColor: AppColors.textTertiary,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(opacity: isLoading ? 0 : 1, child: Text(label)),
          if (isLoading)
            SizedBox(
              width: WidgetDimensions.loaderSize,
              height: WidgetDimensions.loaderSize,
              child: CircularProgressIndicator(
                strokeWidth: WidgetDimensions.loaderStrokeWidth,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    ),
  );
}
