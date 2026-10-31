import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import 'service_details_dimensions.dart';

final class StickyBookBar extends StatelessWidget {
  const StickyBookBar({
    required this.service,
    required this.currencySymbol,
    required this.slot,
    required this.onBook,
    super.key,
  });

  final ServiceEntity? service;
  final String currencySymbol;
  final TimeSlotEntity? slot;
  final ValueChanged<TimeSlotEntity>? onBook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedSlot = slot;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsetsDirectional.all(
          ServiceDetailsDimensions.stickyBarPadding,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.nav,
          border: Border(
            top: BorderSide(
              color: AppColors.border,
              width: ServiceDetailsDimensions.topBorderThickness,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.normal,
                child: _BookingSummary(
                  key: ValueKey(slot?.startsAt),
                  service: service,
                  slot: slot,
                  currencySymbol: currencySymbol,
                ),
              ),
            ),
            const SizedBox(
              width: ServiceDetailsDimensions.stickyBarButtonSpacing,
            ),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                label: selectedSlot == null
                    ? l10n.serviceChooseTimeHint
                    : l10n.serviceBookAt(selectedSlot.time),
                onPressed: selectedSlot == null
                    ? null
                    : () => onBook?.call(selectedSlot),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BookingSummary extends StatelessWidget {
  const _BookingSummary({
    required this.service,
    required this.slot,
    required this.currencySymbol,
    super.key,
  });

  final ServiceEntity? service;
  final TimeSlotEntity? slot;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (slot != null)
        Text(
          slot!.time,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      if (service != null)
        Text(
          '$currencySymbol ${formatPrice(service!.finalPrice)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  );
}
