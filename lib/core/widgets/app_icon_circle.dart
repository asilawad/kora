import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widget_dimensions.dart';

final class AppIconCircle extends StatelessWidget {
  const AppIconCircle({
    required this.icon,
    this.backgroundColor = AppColors.primarySoft,
    this.iconColor = AppColors.primary,
    super.key,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Container(
    width: WidgetDimensions.stateIconContainer,
    height: WidgetDimensions.stateIconContainer,
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      color: iconColor,
      size: WidgetDimensions.stateIconSize,
    ),
  );
}
