import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../domain/entities/slot_period.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../cubit/service_details_state.dart';
import 'service_details_dimensions.dart';
import 'slot_chip.dart';

final class SlotsSection extends StatelessWidget {
  const SlotsSection({
    required this.slots,
    required this.status,
    required this.failure,
    required this.selectedSlot,
    required this.isGroup,
    required this.onSelected,
    required this.onRetry,
    super.key,
  });

  final List<TimeSlotEntity> slots;
  final ServiceDetailsLoadStatus status;
  final Failure? failure;
  final TimeSlotEntity? selectedSlot;
  final bool isGroup;
  final ValueChanged<TimeSlotEntity> onSelected;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (status == ServiceDetailsLoadStatus.loading) {
      return const LinearProgressIndicator(
        color: AppColors.primary,
        minHeight: ServiceDetailsDimensions.dividerThickness,
      );
    }
    if (status == ServiceDetailsLoadStatus.failure) {
      return SizedBox(
        height: ServiceDetailsDimensions.failedContentHeight,
        child: AppErrorView(
          message: failure!.localized(l10n),
          onRetry: onRetry,
        ),
      );
    }
    if (status == ServiceDetailsLoadStatus.initial) {
      return const SizedBox.shrink();
    }
    if (slots.isEmpty) return AppEmptyView(message: l10n.serviceNoSlots);

    final grouped = groupSlotsByPeriod(_displaySlots(slots));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final period in SlotPeriod.values)
          if (grouped[period]!.isNotEmpty) ...[
            Text(
              _periodTitle(l10n, period),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
            Wrap(
              spacing: ServiceDetailsDimensions.smallSpacing,
              runSpacing: ServiceDetailsDimensions.smallSpacing,
              children: [
                for (final slot in grouped[period]!)
                  SlotChip(
                    slot: slot,
                    selected: selectedSlot == slot,
                    isGroup: isGroup,
                    onSelected: onSelected,
                  ),
              ],
            ),
            const SizedBox(height: ServiceDetailsDimensions.itemSpacing),
          ],
      ],
    );
  }

  /// Shows half-hour starts only (:00 / :30) to keep the grid calm; falls
  /// back to every slot when the day has no half-hour starts at all.
  List<TimeSlotEntity> _displaySlots(List<TimeSlotEntity> all) {
    final filtered = all.where((slot) {
      final minutes = int.tryParse(slot.time.split(':').last);
      return minutes != null && minutes % 30 == 0;
    }).toList();
    return filtered.isEmpty ? all : filtered;
  }

  String _periodTitle(AppLocalizations l10n, SlotPeriod period) =>
      switch (period) {
        SlotPeriod.morning => l10n.periodMorning,
        SlotPeriod.afternoon => l10n.periodAfternoon,
        SlotPeriod.evening => l10n.periodEvening,
      };
}
