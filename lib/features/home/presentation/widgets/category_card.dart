import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/category_entity.dart';
import 'home_dimensions.dart';

final class CategoryCard extends StatelessWidget {
  const CategoryCard({required this.category, this.onTap, super.key});

  final CategoryEntity category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: HomeDimensions.categoryCardWidth,
    height: HomeDimensions.categoryCardHeight,
    child: Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(HomeDimensions.serviceCardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (category.image.isEmpty)
              const ColoredBox(
                color: AppColors.grey100,
                child: Icon(
                  Icons.sports_soccer,
                  color: AppColors.textSecondary,
                  size: HomeDimensions.categoryFallbackIconSize,
                ),
              )
            else
              AppNetworkImage(url: category.image),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    AppColors.textPrimary.withValues(
                      alpha: HomeDimensions.transparentOpacity,
                    ),
                    AppColors.textPrimary,
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(
                  HomeDimensions.smallSpacing,
                ),
                child: Text(
                  category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
