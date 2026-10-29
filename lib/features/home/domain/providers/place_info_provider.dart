import '../entities/place_entity.dart';

final class PlaceInfoProvider {
  PlaceEntity? _place;

  PlaceEntity? get place => _place;

  void update(PlaceEntity place) {
    _place = place;
  }
}
