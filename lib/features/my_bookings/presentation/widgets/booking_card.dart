import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/soft_card.dart';
import '../../../../core/widgets/status_pill.dart';
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: MyBookingsDimensions.cardSpacing,
      ),
      child: SoftCard(
        padding: const EdgeInsetsDirectional.all(
          MyBookingsDimensions.cardPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateBlock(date: booking.date, dayLabel: booking.dayLabel),
            const SizedBox(width: MyBookingsDimensions.cardSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.serviceName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: MyBookingsDimensions.smallSpacing),
                  _MetaRow(
                    icon: Icons.schedule_rounded,
                    text: '${booking.time} - ${booking.endTime}',
                  ),
                  if (booking.staff != null)
                    _MetaRow(
                      icon: Icons.sports_soccer_rounded,
                      text: booking.staff!.name,
                    ),
                  const SizedBox(height: MyBookingsDimensions.smallSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${booking.currencySymbol} ${formatPrice(booking.total)}',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: AppColors.primary),
                        ),
                      ),
                      StatusPill(
                        label: booking.statusLabel,
                        variant: _variant(booking.status),
                      ),
                    ],
                  ),
                  if (booking.canCancel)
                    _CancelPill(
                      isCancelling: isCancelling,
                      onPressed: () async {
                        final reason = await CancelBookingDialog.show(
                          context,
                          booking,
                        );
                        if (reason != null) onCancel(reason);
                      },
                    )
                  else if (booking.status == BookingStatus.confirmed)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: MyBookingsDimensions.cardSpacing,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: MyBookingsDimensions.metaIconSize,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(
                            width: MyBookingsDimensions.smallSpacing,
                          ),
                          Expanded(
                            child: Text(
                              l10n.myBookingsCancellationUnavailable,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ),
                        ],
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

  StatusPillVariant _variant(BookingStatus status) => switch (status) {
    BookingStatus.confirmed => StatusPillVariant.success,
    BookingStatus.cancelled => StatusPillVariant.error,
    BookingStatus.inProgress => StatusPillVariant.warning,
    BookingStatus.arrived ||
    BookingStatus.completed => StatusPillVariant.info,
    BookingStatus.unknown => StatusPillVariant.neutral,
  };
}

final class _DateBlock extends StatelessWidget {
  const _DateBlock({required this.date, required this.dayLabel});

  final String date;
  final String dayLabel;

  @override
  Widget build(BuildContext context) => Container(
    width: MyBookingsDimensions.dateBlockSize,
    padding: const EdgeInsetsDirectional.symmetric(
      vertical: MyBookingsDimensions.cardSpacing,
    ),
    decoration: BoxDecoration(
      color: AppColors.primarySoft,
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    child: Column(
      children: [
        Text(
          date.split('-').last,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          dayLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    ),
  );
}

final class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(
      top: MyBookingsDimensions.smallSpacing / 2,
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: MyBookingsDimensions.metaIconSize,
          color: AppColors.textTertiary,
        ),
        const SizedBox(width: MyBookingsDimensions.smallSpacing),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

final class _CancelPill extends StatelessWidget {
  const _CancelPill({required this.isCancelling, required this.onPressed});

  final bool isCancelling;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(
      top: MyBookingsDimensions.cardSpacing,
    ),
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: OutlinedButton(
        onPressed: isCancelling ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.errorText,
          side: const BorderSide(color: AppColors.errorSoft),
          backgroundColor: AppColors.errorSoft,
          minimumSize: const Size(0, MyBookingsDimensions.cancelHeight),
          shape: const StadiumBorder(),
        ),
        child: isCancelling
            ? const SizedBox(
                width: MyBookingsDimensions.metaIconSize,
                height: MyBookingsDimensions.metaIconSize,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(AppLocalizations.of(context)!.myBookingsCancel),
      ),
    ),
  );
}
