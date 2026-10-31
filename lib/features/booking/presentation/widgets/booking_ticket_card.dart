import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../domain/entities/booking_entity.dart';
import '../booking_dimensions.dart';

/// Ticket-style booking summary with a dashed tear line and side notches.
final class BookingTicketCard extends StatelessWidget {
  const BookingTicketCard({required this.booking, super.key});

  final BookingEntity booking;

  static const double _notch = 22;
  static const double _codeSpacing = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(
              BookingDimensions.sheetPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.serviceName, style: theme.titleMedium),
                if (booking.staff != null)
                  Text(
                    booking.staff!.name,
                    style: theme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                const SizedBox(height: BookingDimensions.itemSpacing),
                Row(
                  children: [
                    const Icon(
                      Icons.event_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${booking.dayLabel}, ${booking.date} · ${booking.time}',
                        style: theme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const _TearLine(notch: _notch),
          Padding(
            padding: const EdgeInsetsDirectional.all(
              BookingDimensions.sheetPadding,
            ),
            child: Column(
              children: [
                Text(
                  l10n.bookingNumber(booking.number),
                  style: theme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: _codeSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      booking.code,
                      style: theme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.bookingCopyCode,
                      icon: const Icon(Icons.copy_rounded),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: booking.code),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text(l10n.bookingCodeCopied)),
                          );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: BookingDimensions.itemSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${l10n.bookingPayment}: ${l10n.bookingCashAtVenue}',
                      style: theme.bodySmall,
                    ),
                    Text(
                      '${booking.currencySymbol} ${formatPrice(booking.total)}',
                      style: theme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _TearLine extends StatelessWidget {
  const _TearLine({required this.notch});

  final double notch;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: notch,
    child: Stack(
      alignment: Alignment.center,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: _Dashes(),
        ),
        PositionedDirectional(
          start: -notch / 2,
          child: _Notch(size: notch),
        ),
        PositionedDirectional(
          end: -notch / 2,
          child: _Notch(size: notch),
        ),
      ],
    ),
  );
}

final class _Notch extends StatelessWidget {
  const _Notch({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.border),
    ),
  );
}

final class _Dashes extends StatelessWidget {
  const _Dashes();

  static const double _dash = 6;
  static const double _gap = 5;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final count = (constraints.maxWidth / (_dash + _gap)).floor();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(
          count,
          (_) => const SizedBox(
            width: _dash,
            height: 1.5,
            child: ColoredBox(color: AppColors.border),
          ),
        ),
      );
    },
  );
}
