import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_curves.dart';
import '../theme/app_durations.dart';
import '../theme/app_radius.dart';
import 'widget_dimensions.dart';

final class ChipPill extends StatelessWidget {
  const ChipPill({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.transparent,
    child: InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: AppCurves.standard,
        constraints: const BoxConstraints(
          minHeight: WidgetDimensions.tapTarget,
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: WidgetDimensions.chipPillHorizontalPadding,
          vertical: WidgetDimensions.chipPillVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: selected ? AppColors.textOnPrimary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    ),
  );
}
