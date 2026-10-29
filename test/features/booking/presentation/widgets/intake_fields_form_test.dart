import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/booking/presentation/widgets/intake_fields_form.dart';

HomeDataModel _homeFixture() {
  final envelope = jsonDecode(
    File('test/fixtures/home_response.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return HomeDataModel.fromJson(envelope[ApiResponseKeys.data]);
}

void main() {
  testWidgets('renders text and number intake fields from the home fixture', (
    tester,
  ) async {
    final place = _homeFixture().place;
    Map<String, dynamic> answers = {};

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: IntakeFieldsForm(
            fields: place.intakeFields,
            onAnswersChanged: (value) => answers = value,
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(place.intakeFields.length));
    expect(find.text('Team name'), findsOneWidget);
    expect(find.text('Number of players'), findsOneWidget);
    expect(find.text('لاعب'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, '12');
    expect(answers['players_count'], 12);
    expect(answers['players_count'], isA<int>());
  });
}
