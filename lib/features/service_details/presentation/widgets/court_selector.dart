import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/color_parser.dart';
import '../../../home/domain/entities/service_entity.dart';
import 'service_details_dimensions.dart';

final class CourtSelector extends StatelessWidget {
  const CourtSelector({
    required this.service,
    required this.selectedStaffId,
    required this.onSelected,
    super.key,
  });

  final ServiceEntity service;
  final int? selectedStaffId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    if (service.staff.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.serviceWith, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChoiceChip(
                label: Text(l10n.serviceAnyCourt),
                selected: selectedStaffId == null,
                onSelected: (_) => onSelected(null),
              ),
              for (final staff in service.staff)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: ServiceDetailsDimensions.smallSpacing,
                  ),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      radius: ServiceDetailsDimensions.courtDotSize / 2,
                      backgroundColor:
                          parseHexColor(staff.color) ?? AppColors.primary,
                    ),
                    label: Text(staff.name),
                    selected: selectedStaffId == staff.id,
                    onSelected: (_) => onSelected(staff.id),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
