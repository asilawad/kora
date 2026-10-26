import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/presentation/widgets/home_header.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('shows the place name and open status without description', (
    tester,
  ) async {
    final description = home.place.description!;
    await pumpApp(tester, HomeHeader(place: home.place));
    final context = tester.element(find.byType(HomeHeader));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text(home.place.name), findsOneWidget);
    expect(find.text(description), findsNothing);
    expect(
      find.text(home.place.openNow ? l10n.homeOpenNow : l10n.homeClosedNow),
      findsOneWidget,
    );
  });

}
