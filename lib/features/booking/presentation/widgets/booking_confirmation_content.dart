import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/domain/entities/place_entity.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../../service_details/domain/entities/time_slot_entity.dart';
import '../booking_dimensions.dart';
import 'booking_summary_card.dart';
import 'intake_fields_form.dart';

final class BookingConfirmationContent extends StatelessWidget {
  const BookingConfirmationContent({
    required this.service,
    required this.date,
    required this.dayLabel,
    required this.slot,
    required this.staffName,
    required this.place,
    required this.failure,
    required this.isSubmitting,
    required this.onAnswersChanged,
    required this.notesController,
    required this.onSubmit,
    super.key,
  });

  final ServiceEntity service;
  final String date;
  final String dayLabel;
  final TimeSlotEntity slot;
  final String? staffName;
  final PlaceEntity place;
  final Failure? failure;
  final bool isSubmitting;
  final ValueChanged<Map<String, dynamic>> onAnswersChanged;
  final TextEditingController notesController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.bookingConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: BookingDimensions.sectionSpacing),
          BookingSummaryCard(
            service: service,
            date: date,
            dayLabel: dayLabel,
            slot: slot,
            courtName: staffName,
            currencySymbol: place.currencySymbol,
          ),
          const SizedBox(height: BookingDimensions.sectionSpacing),
          IntakeFieldsForm(
            fields: place.intakeFields,
            onAnswersChanged: onAnswersChanged,
          ),
          TextField(
            controller: notesController,
            decoration: InputDecoration(labelText: l10n.bookingNotesHint),
            minLines: 1,
            maxLines: 3,
          ),
          const SizedBox(height: BookingDimensions.itemSpacing),
          Text(
            l10n.bookingRulesNote(
              place.bookingRules.cancelBeforeHours,
              place.bookingRules.maxActiveBookings,
            ),
          ),
          const SizedBox(height: BookingDimensions.itemSpacing),
          Text('${l10n.bookingPayment}: ${l10n.bookingCashAtVenue}'),
          if (failure != null) ...[
            const SizedBox(height: BookingDimensions.failureSpacing),
            Text(
              failure!.message ?? failure!.localized(l10n),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ],
          const SizedBox(height: BookingDimensions.sectionSpacing),
          _ConfirmBookingButton(
            isSubmitting: isSubmitting,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

final class _ConfirmBookingButton extends StatelessWidget {
  const _ConfirmBookingButton({
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => PrimaryButton(
    label: AppLocalizations.of(context)!.bookingConfirm,
    isLoading: isSubmitting,
    onPressed: isSubmitting ? null : onSubmit,
  );
}
