import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/my_bookings/presentation/widgets/cancel_booking_dialog.dart';

BookingModel _booking() {
  final envelope = jsonDecode(
    File('test/fixtures/bookings_list_upcoming.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final data = Map<String, dynamic>.from(envelope[ApiResponseKeys.data][0])
    ..[ApiResponseKeys.cancelIsLate] = true;
  final service = Map<String, dynamic>.from(data[ApiResponseKeys.service])
    ..[ApiResponseKeys.image] = '';
  data[ApiResponseKeys.service] = service;
  return BookingModel.fromJson(data);
}

void main() {
  testWidgets('warns for late cancellation and returns no reason on dismiss', (
    tester,
  ) async {
    String? result = 'pending';
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await CancelBookingDialog.show(context, _booking());
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('This cancellation may be considered late.'), findsOneWidget);
    await tester.tap(find.text('Keep booking'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(result, isNull);
  });
}
