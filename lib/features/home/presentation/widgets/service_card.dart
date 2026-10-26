import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/price_tag.dart';
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
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    color: AppColors.surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(HomeDimensions.serviceCardRadius),
      side: const BorderSide(
        color: AppColors.border,
        width: HomeDimensions.serviceCardBorderWidth,
      ),
    ),
    child: InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(
        AppColors.surface.withValues(
          alpha: HomeDimensions.transparentOpacity,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(
          HomeDimensions.serviceCardPadding,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(HomeDimensions.smallSpacing),
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
                  const SizedBox(height: HomeDimensions.smallSpacing),
                  Wrap(
                    spacing: HomeDimensions.smallSpacing,
                    runSpacing: HomeDimensions.smallSpacing,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: HomeDimensions.durationIconSize,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(
                            width: HomeDimensions.durationIconGap,
                          ),
                          Text(
                            service.durationLabel,
                            style: Theme.of(context).textTheme.bodySmall,
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
                ],
              ),
            ),
            const SizedBox(width: HomeDimensions.smallSpacing),
            ElevatedButton(
              onPressed: onBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                minimumSize: const Size(
                  0,
                  HomeDimensions.serviceBookButtonHeight,
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: HomeDimensions.serviceBookButtonHorizontalPadding,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    HomeDimensions.smallSpacing,
                  ),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.homeBookNow,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
