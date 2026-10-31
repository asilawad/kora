import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_curves.dart';
import '../theme/app_durations.dart';
import '../theme/app_radius.dart';

/// Pill segmented control driven by a [TabController].
final class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    required this.controller,
    required this.labels,
    super.key,
  });

  final TabController controller;
  final List<String> labels;

  static const double height = 48;
  static const double inset = 4;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    padding: const EdgeInsetsDirectional.all(inset),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      border: Border.all(color: AppColors.border),
    ),
    child: AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        final selected = controller.animation!.value.round();
        return Row(
          children: List<Widget>.generate(
            labels.length,
            (index) => Expanded(
              child: Semantics(
                button: true,
                selected: index == selected,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.animateTo(index),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    curve: AppCurves.standard,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == selected
                          ? AppColors.primary
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      labels[index],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: index == selected
                            ? AppColors.onPrimary
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
