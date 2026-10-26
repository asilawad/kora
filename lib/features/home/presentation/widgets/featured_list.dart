import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/entities/service_entity.dart';
import 'featured_service_card.dart';
import 'home_dimensions.dart';
import 'section_header.dart';

final class FeaturedList extends StatelessWidget {
  const FeaturedList({
    required this.services,
    required this.currencySymbol,
    super.key,
  });

  final List<ServiceEntity> services;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeader(title: AppLocalizations.of(context)!.homeFeatured),
      const SizedBox(height: HomeDimensions.smallSpacing),
      SizedBox(
        height: HomeDimensions.featuredListHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          separatorBuilder: (context, index) =>
              const SizedBox(width: HomeDimensions.itemSpacing),
          itemBuilder: (context, index) => FeaturedServiceCard(
            service: services[index],
            currencySymbol: currencySymbol,
          ),
        ),
      ),
    ],
  );
}
