import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/entities/attribute_display_entity.dart';
import 'service_details_dimensions.dart';

final class AttributeDisplayRow extends StatelessWidget {
  const AttributeDisplayRow({required this.attribute, super.key});

  final AttributeDisplayEntity attribute;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      vertical: ServiceDetailsDimensions.attributeRowVerticalPadding,
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            _localizedLabel(AppLocalizations.of(context)!),
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            _localizedDisplay(AppLocalizations.of(context)!),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );

  String _localizedLabel(AppLocalizations l10n) =>
      switch (attribute.key.toLowerCase()) {
        'sport' => l10n.attributeSport,
        'players' => l10n.attributePlayers,
        'lighting' => l10n.attributeLighting,
        _ => attribute.label,
      };

  String _localizedDisplay(AppLocalizations l10n) =>
      switch (attribute.display.trim().toLowerCase()) {
        'true' || 'yes' || '1' => l10n.yes,
        'false' || 'no' || '0' => l10n.no,
        _ => attribute.display,
      };
}
