import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/auth/presentation/auth_bottom_sheet.dart';
import 'package:kora/features/booking/presentation/pages/booking_success_page.dart';
import 'package:kora/features/booking/presentation/booking_confirm_sheet.dart';
import 'package:kora/features/service_details/presentation/widgets/sticky_book_bar.dart';

import 'app_flow_harness.dart';
import 'app_flow_test_helpers.dart';

void main() {
  testWidgets('browses, authenticates, confirms, and creates a booking', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    final harness = await AppFlowHarness.create();
    await harness.register();
    await tester.pumpWidget(const KoraApp());
    await pumpFrames(tester);

    await chooseServiceCourtDayAndSlot(tester, harness);
    final l10n = AppLocalizations.of(tester.element(find.byType(StickyBookBar)))!;
    await tester.tap(find.text(l10n.serviceBookAt(harness.slots.first.time)));
    await pumpFrames(tester);
    expect(find.byType(AuthBottomSheet), findsOneWidget);

    await authenticateInSheet(tester);
    await pumpFrames(tester);
    expect(find.byType(BookingConfirmSheet), findsOneWidget);
    final confirmLabel = AppLocalizations.of(
      tester.element(find.byType(BookingConfirmSheet)),
    )!.bookingConfirm;
    await tester.ensureVisible(find.text(confirmLabel).last);
    await tester.tap(find.text(confirmLabel).last);
    await pumpFrames(tester);

    expect(find.byType(BookingSuccessPage), findsOneWidget);
    expect(find.textContaining(harness.booking.number), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
  });
}
