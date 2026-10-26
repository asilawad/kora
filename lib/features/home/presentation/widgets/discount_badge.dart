import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'home_dimensions.dart';

final class DiscountBadge extends StatelessWidget {
  const DiscountBadge({required this.percent, super.key});

  final int percent;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.accent,
      borderRadius: BorderRadius.circular(HomeDimensions.discountRadius),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: HomeDimensions.discountHorizontalPadding,
        vertical: HomeDimensions.discountVerticalPadding,
      ),
      child: Text(
        '$percent%',
        style: const TextStyle(color: AppColors.onAccent),
      ),
    ),
  );
}
