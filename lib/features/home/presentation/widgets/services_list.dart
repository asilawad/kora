import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../domain/entities/service_entity.dart';
import 'home_dimensions.dart';
import 'section_header.dart';
import 'service_card.dart';

final class ServicesList extends StatelessWidget {
  const ServicesList({
    required this.services,
    required this.currencySymbol,
    required this.onBook,
    required this.onTap,
    super.key,
  });

  final List<ServiceEntity> services;
  final String currencySymbol;
  final ValueChanged<ServiceEntity> onBook;
  final ValueChanged<ServiceEntity> onTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeader(title: AppLocalizations.of(context)!.homePopular),
      if (services.isEmpty)
        AppEmptyView(message: AppLocalizations.of(context)!.homeNoServices)
      else
        ...services.map(
          (service) => Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: HomeDimensions.itemSpacing,
            ),
            child: ServiceCard(
              service: service,
              currencySymbol: currencySymbol,
              onBook: () => onBook(service),
              onTap: () => onTap(service),
            ),
          ),
        ),
    ],
  );
}
