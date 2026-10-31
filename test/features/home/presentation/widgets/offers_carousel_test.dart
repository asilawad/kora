import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/presentation/widgets/home_dimensions.dart';
import 'package:kora/features/home/presentation/widgets/offers_carousel.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('is hidden when no services have a discount', (tester) async {
    final featured = home.featured
        .where((service) => service.discountPercent == null)
        .toList();
    final popular = home.popular
        .where((service) => service.discountPercent == null)
        .toList();

    await pumpApp(
      tester,
      OffersCarousel(
        featured: featured,
        popular: popular,
        currencySymbol: home.place.currencySymbol,
        onServiceTap: (_) {},
      ),
    );

    expect(find.byType(OffersCarousel), findsOneWidget);
    expect(find.text('عروض مميزة'), findsNothing);
  });

  testWidgets('shows discount and the book action opens the service', (
    tester,
  ) async {
    var opened = false;
    await pumpApp(
      tester,
      OffersCarousel(
        featured: home.featured,
        popular: home.popular,
        currencySymbol: home.place.currencySymbol,
        onServiceTap: (_) => opened = true,
      ),
    );
    await tester.pump();

    final context = tester.element(find.byType(OffersCarousel));
    expect(find.text(AppLocalizations.of(context)!.homeOffers), findsOneWidget);
    expect(find.text('-25%'), findsOneWidget);
    await tester.tap(find.text(AppLocalizations.of(context)!.homeBookNow).first);
    expect(opened, isTrue);
    expect(HomeDimensions.offerAutoAdvanceDuration.inSeconds, 5);
  });
}
