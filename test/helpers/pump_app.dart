import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';

Future<void> pumpApp(WidgetTester tester, Widget child) => tester.pumpWidget(
  MaterialApp(
    locale: const Locale('ar'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  ),
);
