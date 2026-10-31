import 'package:flutter/material.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../domain/entities/service_entity.dart';
import 'home_dimensions.dart';

final class OfferSlide extends StatelessWidget {
  const OfferSlide({
    required this.service,
    required this.currencySymbol,
    required this.onServiceTap,
    required this.onBook,
    super.key,
  });

  final ServiceEntity service;
  final String currencySymbol;
  final VoidCallback onServiceTap;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    child: Material(
      color: AppColors.surfaceMuted,
      child: InkWell(
        onTap: onServiceTap,
        child: SizedBox(
          height: HomeDimensions.offerHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(url: service.image),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      AppColors.textPrimary.withValues(
                        alpha: HomeDimensions.transparentOpacity,
                      ),
                      AppColors.textPrimary.withValues(
                        alpha: HomeDimensions.offerBottomGradientOpacity,
                      ),
                    ],
                    stops: const [
                      HomeDimensions.offerGradientStart,
                      HomeDimensions.offerGradientEnd,
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                top: HomeDimensions.itemSpacing,
                start: HomeDimensions.itemSpacing,
                child: DiscountBadge(percent: service.discountPercent!),
              ),
              PositionedDirectional(
                start: HomeDimensions.itemSpacing,
                end: HomeDimensions.itemSpacing,
                bottom: HomeDimensions.itemSpacing,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    const SizedBox(height: HomeDimensions.smallSpacing),
                    Row(
                      children: [
                        Text(
                          '$currencySymbol ${formatPrice(service.finalPrice)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.textOnPrimary),
                        ),
                        const SizedBox(width: HomeDimensions.smallSpacing),
                        Text(
                          '$currencySymbol ${formatPrice(service.price)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textOnPrimary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: onBook,
                          style: TextButton.styleFrom(
                            minimumSize: const Size(
                              0,
                              HomeDimensions.offerBookButtonHeight,
                            ),
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: HomeDimensions.itemSpacing,
                            ),
                            backgroundColor: AppColors.surface,
                            foregroundColor: AppColors.primary,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.homeBookNow,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
