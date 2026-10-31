import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/category_entity.dart';
import 'home_dimensions.dart';

final class CategoryAvatarItem extends StatelessWidget {
  const CategoryAvatarItem({
    required this.category,
    required this.onTap,
    super.key,
  });

  final CategoryEntity category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: HomeDimensions.categoryCardWidth,
    child: Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HomeDimensions.categoryRadius),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: HomeDimensions.smallSpacing,
          ),
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  width: HomeDimensions.categoryImageSize,
                  height: HomeDimensions.categoryImageSize,
                  child: category.image.isEmpty
                      ? const ColoredBox(
                          color: AppColors.primarySoft,
                          child: Icon(
                            Icons.sports_soccer,
                            color: AppColors.primary,
                            size: HomeDimensions.categoryImageFallbackIconSize,
                          ),
                        )
                      : AppNetworkImage(url: category.image),
                ),
              ),
              const SizedBox(height: HomeDimensions.smallSpacing),
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
