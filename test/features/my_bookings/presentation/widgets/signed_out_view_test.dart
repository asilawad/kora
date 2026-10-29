import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/my_bookings/presentation/widgets/signed_out_view.dart';

void main() {
  testWidgets('shows the signed-out message and login action', (tester) async {
    var loginTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SignedOutView(onLogin: () => loginTapped = true),
        ),
      ),
    );

    expect(find.text('Sign in to view your bookings.'), findsOneWidget);
    await tester.tap(find.text('Log in'));
    expect(loginTapped, isTrue);
  });
}
