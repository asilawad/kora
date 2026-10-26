import 'package:flutter/material.dart';

import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/place_entity.dart';
import 'cover_image_fallback.dart';
import 'home_dimensions.dart';

final class PlaceCoverCard extends StatelessWidget {
  const PlaceCoverCard({required this.place, super.key});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(HomeDimensions.serviceCardRadius),
    child: AppNetworkImage(
      url: place.cover,
      aspectRatio: HomeDimensions.coverAspectRatio,
      placeholder: const CoverImageFallback(),
      errorPlaceholder: const CoverImageFallback(),
    ),
  );
}
