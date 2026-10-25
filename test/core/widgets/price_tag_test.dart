import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/price_tag.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows sale and original prices when discounted', (tester) async {
    await pumpApp(
      tester,
      const PriceTag(price: 120, salePrice: 99.5, currencySymbol: 'ر.س'),
    );

    expect(find.text('ر.س 99.50'), findsOneWidget);
    expect(find.text('ر.س 120'), findsOneWidget);
  });

  testWidgets('shows only the final price without a sale', (tester) async {
    await pumpApp(
      tester,
      const PriceTag(price: 119.99, currencySymbol: 'ر.س'),
    );

    expect(find.text('ر.س 119.99'), findsOneWidget);
    expect(find.text('ر.س 120'), findsNothing);
  });
}
