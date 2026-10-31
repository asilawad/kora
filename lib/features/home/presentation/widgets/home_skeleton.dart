import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/skeleton_box.dart';
import '../../../../core/widgets/skeleton_line.dart';
import 'home_dimensions.dart';

final class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Skeleton(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(HomeDimensions.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              height: HomeDimensions.coverHeight,
              radius: AppRadius.xl,
            ),
            const SizedBox(height: AppSpacing.lg),
            const Row(
              children: [
                SkeletonBox(
                  width: HomeDimensions.logoSize,
                  height: HomeDimensions.logoSize,
                  radius: AppRadius.pill,
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(width: HomeDimensions.skeletonPlaceNameWidth),
                      SizedBox(height: AppSpacing.sm),
                      SkeletonLine(width: HomeDimensions.skeletonAddressWidth),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: HomeDimensions.sectionSpacing),
            const SkeletonBox(height: HomeDimensions.homeSearchHeight),
            const SizedBox(height: HomeDimensions.sectionSpacing),
            const SkeletonBox(height: HomeDimensions.offerHeight),
            const SizedBox(height: HomeDimensions.sectionSpacing),
            SizedBox(
              height: HomeDimensions.categoryCardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: HomeDimensions.skeletonCategoryCount,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: HomeDimensions.itemSpacing),
                itemBuilder: (context, index) => const Column(
                  children: [
                    SkeletonBox(
                      width: HomeDimensions.categoryImageSize,
                      height: HomeDimensions.categoryImageSize,
                      radius: AppRadius.pill,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    SkeletonLine(width: HomeDimensions.skeletonCategoryNameWidth),
                  ],
                ),
              ),
            ),
            const SizedBox(height: HomeDimensions.sectionSpacing),
            for (var index = 0;
                index < HomeDimensions.skeletonServiceCount;
                index++) ...[
              const SkeletonBox(
                height: HomeDimensions.skeletonServiceCardHeight,
              ),
              const SizedBox(height: HomeDimensions.itemSpacing),
            ],
          ],
        ),
      ),
    ),
  );
}
