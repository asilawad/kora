import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widget_dimensions.dart';

final class CourtBadge extends StatelessWidget {
  const CourtBadge({required this.name, this.color, super.key});

  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? AppColors.primary;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: badgeColor.withValues(
          alpha: WidgetDimensions.badgeBackgroundOpacity,
        ),
        borderRadius: BorderRadius.circular(WidgetDimensions.badgeRadius),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: WidgetDimensions.badgeHorizontalPadding,
          vertical: WidgetDimensions.badgeVerticalPadding,
        ),
        child: Text(name, style: TextStyle(color: badgeColor)),
      ),
    );
  }
}
