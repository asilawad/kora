import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/primary_button.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('loading disables the button and shows a spinner', (
    tester,
  ) async {
    var pressed = false;
    await pumpApp(
      tester,
      PrimaryButton(
        label: 'Continue',
        onPressed: () => pressed = true,
        isLoading: true,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull);
    await tester.tap(find.byType(ElevatedButton));
    expect(pressed, isFalse);
  });
}
