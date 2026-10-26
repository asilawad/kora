import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

final class CoverImageFallback extends StatelessWidget {
  const CoverImageFallback({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: AppColors.grey100,
    child: Center(
      child: Icon(
        Icons.image_outlined,
        color: AppColors.grey500,
      ),
    ),
  );
}
