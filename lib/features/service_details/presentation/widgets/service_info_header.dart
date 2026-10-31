import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../../home/domain/entities/rating_entity.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../../../core/widgets/discount_badge.dart';
import 'service_details_dimensions.dart';

final class ServiceInfoHeader extends StatelessWidget {
  const ServiceInfoHeader({
    required this.service,
    required this.currencySymbol,
    this.rating,
    super.key,
  });

  final ServiceEntity service;
  final String currencySymbol;
  final RatingEntity? rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.category.name,
          style: theme.textTheme.labelLarge?.copyWith(
            color: AppColors.accentText,
          ),
        ),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        Text(service.name, style: theme.textTheme.headlineSmall),
        if (rating != null && rating!.count > 0) ...[
          const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.accent),
              const SizedBox(width: ServiceDetailsDimensions.smallSpacing / 2),
              Text(rating!.average.toString()),
              Text(l10n.serviceRatingCount(rating!.count)),
            ],
          ),
        ],
        const SizedBox(height: ServiceDetailsDimensions.itemSpacing),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: ServiceDetailsDimensions.itemSpacing,
          runSpacing: ServiceDetailsDimensions.smallSpacing,
          children: [
            PriceTag(
              price: service.price,
              salePrice: service.salePrice == null ? null : service.finalPrice,
              currencySymbol: currencySymbol,
            ),
            if (service.discountPercent != null)
              DiscountBadge(percent: service.discountPercent!),
            Chip(
              avatar: const Icon(
                Icons.schedule,
                size: ServiceDetailsDimensions.durationIconSize,
                color: AppColors.textSecondary,
              ),
              label: Text(service.durationLabel),
            ),
          ],
        ),
      ],
    );
  }
}
