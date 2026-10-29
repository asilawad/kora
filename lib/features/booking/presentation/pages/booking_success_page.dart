import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/booking_entity.dart';
import '../booking_dimensions.dart';

final class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({required this.booking, super.key});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(BookingDimensions.sheetPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _SuccessMark(),
                const SizedBox(height: BookingDimensions.sectionSpacing),
                Text(
                  l10n.bookingSuccessTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: BookingDimensions.sectionSpacing),
                _BookingSuccessSummary(booking: booking),
                const SizedBox(height: BookingDimensions.sectionSpacing),
                PrimaryButton(
                  label: l10n.bookingViewBookings,
                  onPressed: () =>
                      context.goNamed(AppRoutes.myBookingsName),
                ),
                const SizedBox(height: BookingDimensions.itemSpacing),
                OutlinedButton(
                  onPressed: () => context.goNamed(AppRoutes.homeName),
                  child: Text(l10n.bookingBackHome),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _SuccessMark extends StatelessWidget {
  const _SuccessMark();

  @override
  Widget build(BuildContext context) => const Icon(
    Icons.check_circle,
    color: AppColors.success,
    size: BookingDimensions.successIconSize,
  );
}

final class _BookingSuccessSummary extends StatelessWidget {
  const _BookingSuccessSummary({required this.booking});

  final BookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(l10n.bookingNumber(booking.number)),
        Text(l10n.bookingCode(booking.code)),
        Text(booking.serviceName),
        Text('${booking.dayLabel}, ${booking.date} · ${booking.time}'),
        Text(
          '${booking.currencySymbol} ${formatPrice(booking.total)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text('${l10n.bookingPayment}: ${l10n.bookingCashAtVenue}'),
      ],
    );
  }
}
