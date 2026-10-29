import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../home/domain/entities/attribute_display_entity.dart';
import 'attribute_display_row.dart';
import 'service_details_dimensions.dart';

final class AttributesSection extends StatelessWidget {
  const AttributesSection({required this.attributes, super.key});

  final List<AttributeDisplayEntity> attributes;

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.serviceAttributes,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        for (final attribute in attributes)
          AttributeDisplayRow(attribute: attribute),
      ],
    );
  }
}
