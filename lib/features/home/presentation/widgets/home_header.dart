import 'package:flutter/material.dart';

import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/place_entity.dart';
import 'home_dimensions.dart';
import 'open_status_indicator.dart';

final class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.place, super.key});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ClipOval(
        child: SizedBox(
          width: HomeDimensions.logoSize,
          height: HomeDimensions.logoSize,
          child: AppNetworkImage(url: place.logo),
        ),
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            OpenStatusIndicator(isOpen: place.openNow),
          ],
        ),
      ),
    ],
  );
}
