import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/services/presentation/widgets/services_search_field.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows clear button for entered query and clears it', (
    tester,
  ) async {
    final changed = <String>[];
    await pumpApp(
      tester,
      ServicesSearchField(onChanged: changed.add),
    );

    await tester.enterText(find.byType(TextField), 'court');
    await tester.pump();
    expect(find.byIcon(Icons.clear), findsOneWidget);
    await tester.tap(find.byIcon(Icons.clear));

    expect(changed.last, isEmpty);
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, isEmpty);
  });
}
