import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/my_bookings/presentation/widgets/booking_card.dart';

BookingModel _booking({required bool canCancel}) {
  final envelope = jsonDecode(
    File('test/fixtures/bookings_list_upcoming.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final data = Map<String, dynamic>.from(envelope[ApiResponseKeys.data][0]);
  data[ApiResponseKeys.canCancel] = canCancel;
  final service = Map<String, dynamic>.from(data[ApiResponseKeys.service])
    ..[ApiResponseKeys.image] = '';
  data[ApiResponseKeys.service] = service;
  return BookingModel.fromJson(data);
}

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  testWidgets('shows cancel control only when canCancel is true', (
    tester,
  ) async {
    String? reason;
    await tester.pumpWidget(
      _app(
        BookingCard(
          booking: _booking(canCancel: true),
          isCancelling: false,
          onCancel: (value) => reason = value,
        ),
      ),
    );

    expect(find.text('Cancel booking'), findsOneWidget);
    await tester.tap(find.text('Cancel booking'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Cancel this booking?'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Change of plans');
    await tester.tap(find.text('Confirm cancellation'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(reason, 'Change of plans');
  });

  testWidgets('shows unavailable note when cancellation is disallowed', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        BookingCard(
          booking: _booking(canCancel: false),
          isCancelling: false,
          onCancel: (_) {},
        ),
      ),
    );

    expect(find.text('Cancellation is no longer available.'), findsOneWidget);
    expect(find.text('Cancel booking'), findsNothing);
  });
}
