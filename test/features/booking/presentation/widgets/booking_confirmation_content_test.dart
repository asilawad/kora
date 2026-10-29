import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/booking/presentation/widgets/booking_confirmation_content.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';

HomeDataModel _homeFixture() {
  final envelope = jsonDecode(
    File('test/fixtures/home_response.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return HomeDataModel.fromJson(envelope[ApiResponseKeys.data]);
}

void main() {
  testWidgets('shows an inline server failure', (tester) async {
    final home = _homeFixture();
    final service = home.featured.first;
    final slot = const TimeSlotEntity(
      time: '10:00',
      startsAt: '2026-10-31T10:00:00+02:00',
      endsAt: '2026-10-31T11:00:00+02:00',
      staff: [],
      seatsLeft: 1,
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BookingConfirmationContent(
            service: service,
            date: '2026-10-31',
            dayLabel: 'السبت',
            slot: slot,
            staffName: null,
            place: home.place,
            failure: const ValidationFailure(message: 'لديك حجز آخر'),
            isSubmitting: false,
            onAnswersChanged: (_) {},
            notesController: TextEditingController(),
            onSubmit: () {},
          ),
        ),
      ),
    );

    expect(find.text('لديك حجز آخر'), findsOneWidget);
  });

  testWidgets('uses the loading button state while submitting', (tester) async {
    final home = _homeFixture();
    final slot = const TimeSlotEntity(
      time: '10:00',
      startsAt: '2026-10-31T10:00:00+02:00',
      endsAt: '2026-10-31T11:00:00+02:00',
      staff: [],
      seatsLeft: 1,
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BookingConfirmationContent(
            service: home.featured.first,
            date: '2026-10-31',
            dayLabel: 'السبت',
            slot: slot,
            staffName: null,
            place: home.place,
            failure: null,
            isSubmitting: true,
            onAnswersChanged: (_) {},
            notesController: TextEditingController(),
            onSubmit: () {},
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
  });
}
