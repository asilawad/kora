import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/app_empty_view.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the localized default empty message', (tester) async {
    await pumpApp(tester, const AppEmptyView());

    expect(find.text('لا توجد بيانات لعرضها حاليًا.'), findsOneWidget);
  });
}
