import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import 'widget_dimensions.dart';

final class DiscountBadge extends StatelessWidget {
  const DiscountBadge({required this.percent, super.key});

  final int percent;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: AppColors.accentSoft,
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: WidgetDimensions.discountHorizontalPadding,
        vertical: WidgetDimensions.discountVerticalPadding,
      ),
      child: Text(
        '-$percent%',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.accentText,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
