import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../../../core/widgets/soft_card.dart';
import '../../domain/entities/service_entity.dart';
import 'home_dimensions.dart';

final class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.service,
    required this.currencySymbol,
    this.onBook,
    this.onTap,
    super.key,
  });

  final ServiceEntity service;
  final String currencySymbol;
  final VoidCallback? onBook;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => SoftCard(
    onTap: onTap,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: SizedBox(
            width: HomeDimensions.serviceImageSize,
            height: HomeDimensions.serviceImageSize,
            child: AppNetworkImage(url: service.thumb),
          ),
        ),
        const SizedBox(width: HomeDimensions.itemSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                service.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: HomeDimensions.serviceMetaGap),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    size: HomeDimensions.durationIconSize,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: HomeDimensions.durationIconGap),
                  Flexible(
                    child: Text(
                      service.durationLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  if (service.attributes.sport case final sport?)
                    Flexible(
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(
                          start: HomeDimensions.serviceMetaGap,
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: HomeDimensions.serviceAttributePillHorizontal,
                          vertical: HomeDimensions.serviceAttributePillVertical,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          sport,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
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
        const SizedBox(width: HomeDimensions.smallSpacing),
        SizedBox(
          width: HomeDimensions.serviceBookButtonWidth,
          height: HomeDimensions.serviceBookButtonHeight,
          child: FilledButton(
            onPressed: onBook,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(
                HomeDimensions.serviceBookButtonHeight,
              ),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              textStyle: Theme.of(context).textTheme.labelSmall,
            ),
            child: Text(
              AppLocalizations.of(context)!.homeBookNow,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    ),
  );
}
