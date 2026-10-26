import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/presentation/widgets/category_chips.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('selecting a category returns its id', (tester) async {
    int? selectedId;
    final category = home.categories.first;
    await pumpApp(
      tester,
      CategoryChips(
        categories: home.categories,
        selectedCategoryId: null,
        onSelected: (id) => selectedId = id,
      ),
    );

    await tester.tap(find.text(category.name));

    expect(selectedId, category.id);
  });

  testWidgets('selecting All returns null', (tester) async {
    var selectedAll = false;
    await pumpApp(
      tester,
      CategoryChips(
        categories: home.categories,
        selectedCategoryId: home.categories.first.id,
        onSelected: (id) => selectedAll = id == null,
      ),
    );

    await tester.tap(find.text('الكل'));

    expect(selectedAll, isTrue);
  });
}
