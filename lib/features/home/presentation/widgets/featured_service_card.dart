import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../../../core/widgets/soft_card.dart';
import '../../domain/entities/service_entity.dart';
import 'home_dimensions.dart';

final class FeaturedServiceCard extends StatelessWidget {
  const FeaturedServiceCard({
    required this.service,
    required this.currencySymbol,
    this.onTap,
    super.key,
  });

  final ServiceEntity service;
  final String currencySymbol;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: HomeDimensions.featuredCardWidth,
    child: SoftCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: HomeDimensions.featuredCardImageHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppNetworkImage(url: service.image),
                if (service.discountPercent != null)
                  PositionedDirectional(
                    top: HomeDimensions.smallSpacing,
                    start: HomeDimensions.smallSpacing,
                    child: DiscountBadge(percent: service.discountPercent!),
                  ),
                PositionedDirectional(
                  top: HomeDimensions.smallSpacing,
                  end: HomeDimensions.smallSpacing,
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: HomeDimensions.durationPillPadding,
                      vertical: HomeDimensions.durationPillPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          size: HomeDimensions.durationPillIconSize,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(
                          width: HomeDimensions.durationPillIconGap,
                        ),
                        Text(
                          service.durationLabel,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.all(
              HomeDimensions.featuredContentPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                PriceTag(
                  price: service.price,
                  salePrice: service.salePrice == null
                      ? null
                      : service.finalPrice,
                  currencySymbol: currencySymbol,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
