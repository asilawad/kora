import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/widgets/app_network_image.dart';
import 'package:kora/features/home/presentation/widgets/place_cover_card.dart';
import 'package:kora/features/home/presentation/widgets/home_dimensions.dart';
import 'package:kora/features/home/presentation/widgets/open_status_indicator.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';

import '../../../../helpers/pump_app.dart';
import '../../helpers/load_home_model.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('renders a plain cover image without status or name overlays', (
    tester,
  ) async {
    await pumpApp(tester, PlaceCoverCard(place: home.place));

    final image = tester.widget<AppNetworkImage>(find.byType(AppNetworkImage));
    expect(image.aspectRatio, HomeDimensions.coverAspectRatio);
    expect(image.placeholder, isNotNull);
    expect(image.errorPlaceholder, isNotNull);
    final context = tester.element(find.byType(AppNetworkImage));
    expect(
      find.text(AppLocalizations.of(context)!.homeOpenNow),
      findsNothing,
    );
    expect(find.byType(OpenStatusIndicator), findsNothing);
    expect(find.text(home.place.name), findsNothing);
  });
}
