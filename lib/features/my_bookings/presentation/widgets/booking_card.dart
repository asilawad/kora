import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../my_bookings_dimensions.dart';
import 'cancel_booking_dialog.dart';

final class BookingCard extends StatelessWidget {
  const BookingCard({
    required this.booking,
    required this.isCancelling,
    required this.onCancel,
    super.key,
  });

  final BookingEntity booking;
  final bool isCancelling;
  final ValueChanged<String?> onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: MyBookingsDimensions.cardSpacing),
      child: Padding(
        padding: const EdgeInsets.all(MyBookingsDimensions.cardPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MyBookingsDimensions.imageSize,
              height: MyBookingsDimensions.imageSize,
              child: AppNetworkImage(
                url: booking.serviceImage,
                borderRadius: BorderRadius.circular(
                  MyBookingsDimensions.imageRadius,
                ),
              ),
            ),
            const SizedBox(width: MyBookingsDimensions.cardSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          booking.serviceName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      _BookingStatusChip(booking: booking),
                    ],
                  ),
                  if (booking.staff != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: MyBookingsDimensions.smallSpacing,
                      ),
                      child: Text(booking.staff!.name),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: MyBookingsDimensions.smallSpacing,
                    ),
                    child: Text(
                      '${booking.dayLabel}, ${booking.date} · ${booking.time}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: MyBookingsDimensions.smallSpacing,
                    ),
                    child: Text(
                      '${booking.currencySymbol} ${formatPrice(booking.total)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (booking.canCancel)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: isCancelling
                            ? null
                            : () async {
                                final reason = await CancelBookingDialog.show(
                                  context,
                                  booking,
                                );
                                if (reason != null) onCancel(reason);
                              },
                        child: isCancelling
                            ? const SizedBox(
                                width: MyBookingsDimensions.smallSpacing * 2,
                                height: MyBookingsDimensions.smallSpacing * 2,
                                child: CircularProgressIndicator(
                                  strokeWidth:
                                      MyBookingsDimensions.smallSpacing / 3,
                                ),
                              )
                            : Text(l10n.myBookingsCancel),
                      ),
                    )
                  else if (booking.status == BookingStatus.confirmed)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: MyBookingsDimensions.smallSpacing,
                      ),
                      child: Text(
                        l10n.myBookingsCancellationUnavailable,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BookingStatusChip extends StatelessWidget {
  const _BookingStatusChip({required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final color = switch (booking.status) {
      BookingStatus.confirmed => AppColors.success,
      BookingStatus.cancelled => AppColors.grey500,
      BookingStatus.arrived => AppColors.primary,
      BookingStatus.inProgress => AppColors.accent,
      BookingStatus.completed => AppColors.primaryDark,
      BookingStatus.unknown => AppColors.grey700,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MyBookingsDimensions.statusHorizontalPadding,
        vertical: MyBookingsDimensions.statusVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(MyBookingsDimensions.statusRadius),
      ),
      child: Text(
        booking.statusLabel,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}
