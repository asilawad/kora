import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';

void main() {
  testWidgets('launches the localized splash page', (WidgetTester tester) async {
    await tester.pumpWidget(const KoraApp());
    await tester.pumpAndSettle();

    expect(find.text('كورة'), findsOneWidget);
  });
}
