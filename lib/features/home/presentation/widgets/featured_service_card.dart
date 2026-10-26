import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../domain/entities/service_entity.dart';
import 'discount_badge.dart';
import 'home_dimensions.dart';

final class FeaturedServiceCard extends StatelessWidget {
  const FeaturedServiceCard({
    required this.service,
    required this.currencySymbol,
    super.key,
  });

  final ServiceEntity service;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Align(
    alignment: AlignmentDirectional.topStart,
    child: SizedBox(
      width: HomeDimensions.featuredCardWidth,
      child: Card(
        margin: const EdgeInsets.all(HomeDimensions.featuredCardMargin),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: HomeDimensions.featuredImageHeight,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(
                HomeDimensions.smallSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
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
    ),
  );
}
