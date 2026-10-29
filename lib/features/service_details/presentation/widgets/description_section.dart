import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import 'service_details_dimensions.dart';

final class DescriptionSection extends StatelessWidget {
  const DescriptionSection({required this.description, super.key});

  final String? description;

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.serviceDescription,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        Text(description!),
      ],
    );
  }
}
