import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/app_error_view.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the supplied error message', (tester) async {
    await pumpApp(
      tester,
      const AppErrorView(message: 'Network unavailable', onRetry: _doNothing),
    );

    expect(find.text('Network unavailable'), findsOneWidget);
  });

  testWidgets('calls retry when tapped', (tester) async {
    var retried = false;
    await pumpApp(
      tester,
      AppErrorView(message: 'Network unavailable', onRetry: () => retried = true),
    );

    await tester.tap(find.text('إعادة المحاولة'));
    expect(retried, isTrue);
  });

  testWidgets('fits in a small bounded area without overflow', (tester) async {
    await pumpApp(
      tester,
      const SizedBox(
        width: 180,
        height: 120,
        child: AppErrorView(message: 'Network unavailable', onRetry: _doNothing),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

void _doNothing() {}
