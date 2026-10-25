import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';
import 'package:kora/features/home/presentation/pages/home_page.dart';

void main() {
  testWidgets('opens the home page directly', (WidgetTester tester) async {
    await tester.pumpWidget(const KoraApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
