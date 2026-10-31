import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/soft_card.dart';
import '../../domain/entities/place_entity.dart';
import 'cover_image_fallback.dart';
import 'home_dimensions.dart';
import 'open_status_indicator.dart';

final class FloatingPlaceHeader extends StatelessWidget {
  const FloatingPlaceHeader({required this.place, super.key});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: HomeDimensions.coverHeight +
        HomeDimensions.floatingPlaceCardHeight -
        HomeDimensions.coverOverlap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          height: HomeDimensions.coverHeight,
          child: ClipRRect(
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(AppRadius.xl),
              bottomEnd: Radius.circular(AppRadius.xl),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppNetworkImage(
                  url: place.cover,
                  placeholder: const CoverImageFallback(),
                  errorPlaceholder: const CoverImageFallback(),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.center,
                      colors: [
                        AppColors.textPrimary.withValues(
                          alpha: HomeDimensions.coverScrimOpacity,
                        ),
                        AppColors.textPrimary.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: SizedBox(
            height: HomeDimensions.floatingPlaceCardHeight,
            child: SoftCard(
              padding: const EdgeInsetsDirectional.all(
                HomeDimensions.floatingCardPadding,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: HomeDimensions.logoSize,
                        height: HomeDimensions.logoSize,
                        padding: const EdgeInsets.all(
                          HomeDimensions.coverLogoBorder,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.border),
                          boxShadow: AppShadows.card,
                        ),
                        child: ClipOval(child: AppNetworkImage(url: place.logo)),
                      ),
                      const SizedBox(width: HomeDimensions.itemSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            if (place.contact.address.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.textSecondary,
                                    size: HomeDimensions.locationIconSize,
                                  ),
                                  const SizedBox(
                                    width: HomeDimensions.locationIconGap,
                                  ),
                                  Expanded(
                                    child: Text(
                                      place.contact.address,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: HomeDimensions.smallSpacing),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: OpenStatusIndicator(isOpen: place.openNow),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
