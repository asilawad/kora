import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'home_dimensions.dart';

final class OfferPageIndicator extends StatelessWidget {
  const OfferPageIndicator({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: HomeDimensions.indicatorDuration,
    margin: const EdgeInsetsDirectional.symmetric(
      horizontal: HomeDimensions.offerDotGap / 2,
    ),
    width: selected
        ? HomeDimensions.offerActiveDotWidth
        : HomeDimensions.offerDotWidth,
    height: HomeDimensions.offerDotHeight,
    decoration: BoxDecoration(
      color: selected ? AppColors.primary : AppColors.border,
      borderRadius: BorderRadius.circular(HomeDimensions.discountRadius),
    ),
  );
}
