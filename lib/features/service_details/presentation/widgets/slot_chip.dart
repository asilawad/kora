import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/time_slot_entity.dart';
import 'service_details_dimensions.dart';

final class SlotChip extends StatelessWidget {
  const SlotChip({
    required this.slot,
    required this.selected,
    required this.isGroup,
    required this.onSelected,
    super.key,
  });

  final TimeSlotEntity slot;
  final bool selected;
  final bool isGroup;
  final ValueChanged<TimeSlotEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    final showSeats =
        isGroup &&
        slot.seatsLeft >= ServiceDetailsDimensions.minimumSeatCount &&
        slot.seatsLeft < ServiceDetailsDimensions.smallSeatsThreshold;
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onSelected(slot),
      label: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: ServiceDetailsDimensions.slotChipMinimumWidth,
          minHeight: ServiceDetailsDimensions.slotChipMinimumHeight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(slot.time),
            if (showSeats)
              Text(
                AppLocalizations.of(context)!.seatsLeft(slot.seatsLeft),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected ? AppColors.onPrimary : AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: selected ? AppColors.onPrimary : AppColors.textPrimary,
      ),
    );
  }
}
