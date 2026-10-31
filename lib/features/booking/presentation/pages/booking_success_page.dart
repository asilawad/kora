import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../app_shell/presentation/app_shell_navigation.dart';
import '../../domain/entities/booking_entity.dart';
import '../booking_dimensions.dart';
import '../widgets/booking_ticket_card.dart';

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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: BookingDimensions.sectionSpacing),
                BookingTicketCard(booking: booking),
                const SizedBox(height: BookingDimensions.sectionSpacing),
                PrimaryButton(
                  label: l10n.bookingViewBookings,
                  onPressed: () {
                    if (!AppShellNavigation.goToBookings()) {
                      context.goNamed(AppRoutes.myBookingsName);
                    }
                  },
                ),
                const SizedBox(height: BookingDimensions.itemSpacing),
                TextButton(
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

  static const double _circle = 96;

  @override
  Widget build(BuildContext context) => Center(
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppDurations.slow,
      curve: Curves.easeOutBack,
      builder: (context, value, child) => Opacity(
        opacity: value.clamp(0, 1),
        child: Transform.scale(scale: value, child: child),
      ),
      child: Container(
        width: _circle,
        height: _circle,
        decoration: const BoxDecoration(
          color: AppColors.successSoft,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: AppColors.success,
          size: BookingDimensions.successIconSize,
        ),
      ),
    ),
  );
}
