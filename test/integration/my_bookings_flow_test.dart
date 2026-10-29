import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';
import 'package:kora/core/di/injection.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/app_shell/presentation/app_shell.dart';
import 'package:kora/features/my_bookings/presentation/widgets/cancel_booking_dialog.dart';

import 'app_flow_harness.dart';
import 'app_flow_test_helpers.dart';

void main() {
  testWidgets('loads upcoming bookings and cancels an eligible booking', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    final harness = await AppFlowHarness.create();
    await harness.register();
    await sl<AuthCubit>().login(
      const LoginParams(email: 'member@example.com', password: 'password'),
    );
    await tester.pumpWidget(const KoraApp());
    await pumpFrames(tester);

    final l10n = AppLocalizations.of(tester.element(find.byType(AppShell)))!;
    await tester.tap(find.text(l10n.navigationBookings));
    await pumpFrames(tester);
    final booking = harness.bookingsPage.items.first;
    expect(find.text(booking.serviceName), findsOneWidget);

    await tester.tap(find.text(l10n.myBookingsCancel));
    await pumpFrames(tester);
    expect(find.byType(CancelBookingDialog), findsOneWidget);
    await tester.tap(find.text(l10n.myBookingsConfirmCancel));
    await pumpFrames(tester);

    expect(find.text(booking.serviceName), findsNothing);
    expect(find.text('تم إلغاء الحجز'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
  });
}
