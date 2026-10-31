import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/domain/entities/category_entity.dart';
import 'package:kora/features/home/presentation/widgets/category_avatar_item.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('category tap invokes its callback', (tester) async {
    final source = home.categories.first;
    final category = CategoryEntity(
      id: source.id,
      name: source.name,
      icon: source.icon,
      image: '',
      sortOrder: source.sortOrder,
      servicesCount: source.servicesCount,
    );
    var tapped = false;

    await pumpApp(
      tester,
      CategoryAvatarItem(
        category: category,
        onTap: () => tapped = true,
      ),
    );
    await tester.tap(find.byType(CategoryAvatarItem));

    expect(tapped, isTrue);
  });
}
