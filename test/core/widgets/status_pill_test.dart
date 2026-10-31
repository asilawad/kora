import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/status_pill.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('renders its label and status icon', (tester) async {
    await pumpApp(
      tester,
      const StatusPill(
        label: 'Open now',
        variant: StatusPillVariant.success,
        icon: Icons.check_circle_outline,
      ),
    );

    expect(find.text('Open now'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });
}
