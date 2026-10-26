import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/services/domain/entities/service_sort.dart';
import 'package:kora/features/services/presentation/widgets/services_sort_button.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('selecting a sort option returns that sort', (tester) async {
    ServiceSort? selected;
    await pumpApp(
      tester,
      ServicesSortButton(
        selectedSort: ServiceSort.popular,
        onSelected: (sort) => selected = sort,
      ),
    );

    final context = tester.element(find.byType(ServicesSortButton));
    final sortLabel = AppLocalizations.of(context)!.sortPriceAsc;
    await tester.tap(find.byType(ServicesSortButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(sortLabel));
    await tester.pumpAndSettle();

    expect(selected, ServiceSort.priceAsc);
  });
}
