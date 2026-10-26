import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/domain/entities/category_entity.dart';
import 'package:kora/features/home/presentation/widgets/category_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows category name and fallback icon when image is empty', (
    tester,
  ) async {
    final category = CategoryEntity(
      id: 46,
      name: 'Football',
      icon: 'tag',
      image: '',
      sortOrder: 1,
      servicesCount: 2,
    );
    var tapped = false;
    await pumpApp(
      tester,
      CategoryCard(category: category, onTap: () => tapped = true),
    );

    expect(find.text('Football'), findsOneWidget);
    expect(find.byIcon(Icons.sports_soccer), findsOneWidget);
    await tester.tap(find.byType(CategoryCard));
    expect(tapped, isTrue);
  });
}
