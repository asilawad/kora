import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import 'widget_dimensions.dart';

enum StatusPillVariant { success, warning, error, info, neutral }

final class StatusPill extends StatelessWidget {
  const StatusPill({
    required this.label,
    this.variant = StatusPillVariant.neutral,
    this.icon,
    super.key,
  });

  final String label;
  final StatusPillVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (variant) {
      StatusPillVariant.success => (
        AppColors.successSoft,
        AppColors.successText,
      ),
      StatusPillVariant.warning => (
        AppColors.warningSoft,
        AppColors.warningText,
      ),
      StatusPillVariant.error => (
        AppColors.errorSoft,
        AppColors.errorText,
      ),
      StatusPillVariant.info => (AppColors.primarySoft, AppColors.primary),
      StatusPillVariant.neutral => (AppColors.surfaceMuted, AppColors.textSecondary),
    };
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: WidgetDimensions.statusPillHorizontalPadding,
        vertical: WidgetDimensions.statusPillVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: WidgetDimensions.statusPillIconSize,
              color: foreground,
            )
          else
            Container(
              width: WidgetDimensions.statusDotSize,
              height: WidgetDimensions.statusDotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: foreground,
              ),
            ),
          const SizedBox(width: WidgetDimensions.statusPillGap),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
