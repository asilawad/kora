import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../domain/entities/related_service_entity.dart';
import 'service_details_dimensions.dart';

final class RelatedServiceCard extends StatelessWidget {
  const RelatedServiceCard({
    required this.service,
    required this.currencySymbol,
    required this.onTap,
    super.key,
  });

  final RelatedServiceEntity service;
  final String currencySymbol;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: ServiceDetailsDimensions.relatedCardWidth,
    child: Card(
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ServiceDetailsDimensions.relatedImageHeight,
              width: double.infinity,
              child: AppNetworkImage(url: service.thumb),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(
                ServiceDetailsDimensions.smallSpacing,
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
