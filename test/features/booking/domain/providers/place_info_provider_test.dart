import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/domain/providers/place_info_provider.dart';

import '../../../home/helpers/load_home_model.dart';

void main() {
  test('stores the latest successful home place', () async {
    final place = (await loadHomeModel()).place;
    final provider = PlaceInfoProvider();

    expect(provider.place, isNull);
    provider.update(place);

    expect(provider.place, same(place));
  });
}
