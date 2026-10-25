import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/court_badge.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the court name', (tester) async {
    await pumpApp(tester, const CourtBadge(name: 'Court One'));

    expect(find.text('Court One'), findsOneWidget);
  });
}
