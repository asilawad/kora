import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/router/app_routes.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/presentation/pages/booking_success_page.dart';

BookingModel _booking() {
  final envelope = jsonDecode(
    File('test/fixtures/booking_create_success_response.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return BookingModel.fromJson(envelope['data'] as Map<String, dynamic>);
}

GoRouter _router() => GoRouter(
  initialLocation: AppRoutes.bookingSuccessPath,
  routes: [
    GoRoute(
      path: AppRoutes.bookingSuccessPath,
      name: AppRoutes.bookingSuccessName,
      builder: (context, state) => BookingSuccessPage(booking: _booking()),
    ),
    GoRoute(
      path: AppRoutes.myBookingsPath,
      name: AppRoutes.myBookingsName,
      builder: (context, state) => const Scaffold(
        body: Text('Bookings destination'),
      ),
    ),
    GoRoute(
      path: '/home',
      name: AppRoutes.homeName,
      builder: (context, state) => const Scaffold(body: Text('Home destination')),
    ),
  ],
);

void main() {
  testWidgets('View my bookings navigates to the bookings route', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.tap(find.text('عرض حجوزاتي'));
    await tester.pumpAndSettle();
    expect(find.text('Bookings destination'), findsOneWidget);
    router.dispose();
  });

  testWidgets('Back to home navigates to the home route', (tester) async {
    final router = _router();
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.tap(find.text('العودة للرئيسية'));
    await tester.pumpAndSettle();
    expect(find.text('Home destination'), findsOneWidget);
    router.dispose();
  });
}
