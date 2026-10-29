import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../features/home/domain/entities/service_entity.dart';
import '../../../service_details/domain/entities/time_slot_entity.dart';
import '../booking_dimensions.dart';

final class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    required this.service,
    required this.date,
    required this.dayLabel,
    required this.slot,
    required this.courtName,
    required this.currencySymbol,
    super.key,
  });

  final ServiceEntity service;
  final String date;
  final String dayLabel;
  final TimeSlotEntity slot;
  final String? courtName;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
      padding: const EdgeInsets.all(BookingDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(BookingDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(service.name, style: Theme.of(context).textTheme.titleMedium),
          if (courtName != null)
            _SummaryLine(label: l10n.bookingCourt, value: courtName!),
          _SummaryLine(
            label: l10n.bookingDateTime,
            value: '$dayLabel, $date · ${slot.time}',
          ),
          _SummaryLine(
            label: l10n.bookingDurationLabel,
            value: l10n.bookingDuration(service.durationMinutes),
          ),
          _SummaryLine(
            label: l10n.bookingTotalPrice,
            value: '$currencySymbol ${formatPrice(service.finalPrice)}',
            style: textStyle?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

final class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    this.style,
  });

  final String label;
  final String value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: BookingDimensions.itemSpacing),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        Expanded(child: Text(value, style: style, textAlign: TextAlign.end)),
      ],
    ),
  );
}
