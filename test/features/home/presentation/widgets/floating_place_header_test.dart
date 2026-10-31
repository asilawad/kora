import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/domain/entities/place_contact_entity.dart';
import 'package:kora/features/home/domain/entities/place_entity.dart';
import 'package:kora/features/home/presentation/widgets/floating_place_header.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  testWidgets('shows place name and open status but hides an empty address', (
    tester,
  ) async {
    final place = _withoutAddress(home.place);
    await pumpApp(tester, FloatingPlaceHeader(place: place));

    final context = tester.element(find.byType(FloatingPlaceHeader));
    expect(find.text(place.name), findsOneWidget);
    expect(
      find.text(AppLocalizations.of(context)!.homeOpenNow),
      findsOneWidget,
    );
    expect(find.text(place.contact.address), findsNothing);
  });
}

PlaceEntity _withoutAddress(PlaceEntity place) => PlaceEntity(
  id: place.id,
  name: place.name,
  slug: place.slug,
  description: place.description,
  logo: place.logo,
  cover: place.cover,
  currency: place.currency,
  currencySymbol: place.currencySymbol,
  timezone: place.timezone,
  openNow: true,
  labels: place.labels,
  contact: PlaceContactEntity(
    phone: place.contact.phone,
    whatsapp: place.contact.whatsapp,
    address: '',
  ),
  openingHours: place.openingHours,
  rating: place.rating,
  bookingRules: place.bookingRules,
  intakeFields: place.intakeFields,
);
