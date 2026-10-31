import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_curves.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_radius.dart';
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
    final textColor = selected ? AppColors.onPrimary : AppColors.textPrimary;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () {
            HapticFeedback.selectionClick();
            onSelected(slot);
          },
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: AppCurves.standard,
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              minWidth: ServiceDetailsDimensions.slotChipMinimumWidth,
              minHeight: ServiceDetailsDimensions.slotChipMinimumHeight,
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: ServiceDetailsDimensions.itemSpacing,
              vertical: ServiceDetailsDimensions.smallSpacing / 2,
            ),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  slot.time,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (showSeats)
                  Text(
                    AppLocalizations.of(context)!.seatsLeft(slot.seatsLeft),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: selected
                          ? AppColors.onPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
