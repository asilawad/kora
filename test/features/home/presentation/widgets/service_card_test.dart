import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/presentation/widgets/home_dimensions.dart';
import 'package:kora/features/home/presentation/widgets/service_card.dart';
import 'package:kora/core/widgets/soft_card.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('shows original price struck through only for sale services', (
    tester,
  ) async {
    final saleService = home.featured.firstWhere(
      (service) => service.id == 77,
    );
    await pumpApp(
      tester,
      ServiceCard(service: saleService, currencySymbol: home.place.currencySymbol),
    );

    final originalPrice = tester.widget<Text>(find.text('₪ 160'));
    expect(originalPrice.style?.decoration, TextDecoration.lineThrough);

    final regularService = home.popular.firstWhere(
      (service) => service.id == 74,
    );
    await pumpApp(
      tester,
      ServiceCard(
        service: regularService,
        currencySymbol: home.place.currencySymbol,
      ),
    );
    final regularPriceFinder = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data?.contains('120') == true,
    );
    expect(regularPriceFinder, findsOneWidget);
    expect(
      tester.widget<Text>(regularPriceFinder).style?.decoration,
      isNot(TextDecoration.lineThrough),
    );
  });

  testWidgets('Book button triggers its callback', (tester) async {
    var booked = false;
    final service = home.popular.first;
    await pumpApp(
      tester,
      ServiceCard(
        service: service,
        currencySymbol: home.place.currencySymbol,
        onBook: () => booked = true,
      ),
    );

    final buttonFinder = find.ancestor(
      of: find.text('احجز الآن'),
      matching: find.byType(FilledButton),
    );
    final buttonSize = tester.getSize(buttonFinder);
    expect(buttonSize.height, HomeDimensions.serviceBookButtonHeight);
    expect(
      buttonSize.width,
      lessThan(tester.getSize(find.byType(SoftCard)).width),
    );

    await tester.tap(buttonFinder);

    expect(booked, isTrue);
  });
}
