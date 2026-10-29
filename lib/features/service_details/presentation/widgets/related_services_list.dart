import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/entities/related_service_entity.dart';
import 'related_service_card.dart';
import 'service_details_dimensions.dart';

final class RelatedServicesList extends StatelessWidget {
  const RelatedServicesList({
    required this.services,
    required this.currencySymbol,
    super.key,
  });

  final List<RelatedServiceEntity> services;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.relatedServices,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        SizedBox(
          height: ServiceDetailsDimensions.relatedCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: ServiceDetailsDimensions.itemSpacing,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              return RelatedServiceCard(
                service: service,
                currencySymbol: currencySymbol,
                onTap: () => context.pushNamed(
                  AppRoutes.serviceDetailsName,
                  pathParameters: {
                    AppRoutes.serviceIdParameter: service.id.toString(),
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
