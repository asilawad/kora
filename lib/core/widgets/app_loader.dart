import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widget_dimensions.dart';

final class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: CircularProgressIndicator(
      strokeWidth: WidgetDimensions.loaderStrokeWidth,
      color: AppColors.primary,
    ),
  );
}
