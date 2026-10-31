import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../my_bookings_dimensions.dart';

final class CancelBookingDialog extends StatefulWidget {
  const CancelBookingDialog({required this.booking, super.key});

  final BookingEntity booking;

  static Future<String?> show(BuildContext context, BookingEntity booking) =>
      showDialog<String>(
        context: context,
        builder: (_) => CancelBookingDialog(booking: booking),
      );

  @override
  State<CancelBookingDialog> createState() => _CancelBookingDialogState();
}

final class _CancelBookingDialogState extends State<CancelBookingDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.myBookingsCancelTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.myBookingsCancelMessage),
            if (widget.booking.cancelIsLate) ...[
              const SizedBox(height: MyBookingsDimensions.sectionSpacing),
              Text(
                l10n.myBookingsCancelLateWarning,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.errorText,
                ),
              ),
            ],
            const SizedBox(height: MyBookingsDimensions.sectionSpacing),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: l10n.myBookingsCancelReason,
              ),
              minLines: 1,
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.myBookingsKeepBooking),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(_reasonController.text.trim()),
          child: Text(l10n.myBookingsConfirmCancel),
        ),
      ],
    );
  }
}
