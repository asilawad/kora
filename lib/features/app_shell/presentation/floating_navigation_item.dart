import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_curves.dart';
import '../../../core/theme/app_durations.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import 'app_shell_dimensions.dart';
import 'floating_navigation_destination.dart';

final class FloatingNavigationItem extends StatelessWidget {
  const FloatingNavigationItem({
    required this.destination,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final FloatingNavigationDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: destination.label,
    child: Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: AppCurves.standard,
          constraints: const BoxConstraints(
            minHeight: AppShellDimensions.navTapHeight,
          ),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: selected
                ? AppSpacing.lg
                : AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.primarySoft : AppColors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? destination.selectedIcon : destination.icon,
                color: selected ? AppColors.primary : AppColors.textTertiary,
                size: AppShellDimensions.navIconSize,
              ),
              if (selected) ...[
              const SizedBox(width: AppSpacing.sm),
              AnimatedOpacity(
                opacity: selected
                    ? AppShellDimensions.selectedOpacity
                    : AppShellDimensions.unselectedOpacity,
                duration: AppDurations.normal,
                child: Text(
                  destination.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: selected
                        ? AppColors.primary
                        : AppColors.textTertiary,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
