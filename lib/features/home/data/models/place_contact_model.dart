import '../../domain/entities/place_contact_entity.dart';
import 'home_json_keys.dart';

final class PlaceContactModel extends PlaceContactEntity {
  const PlaceContactModel({
    required super.phone,
    required super.whatsapp,
    required super.address,
  });

  factory PlaceContactModel.fromJson(Map<String, dynamic> json) =>
      PlaceContactModel(
        phone: json[HomeJsonKeys.phone] as String,
        whatsapp: json[HomeJsonKeys.whatsapp] as String,
        address: json[HomeJsonKeys.address] as String,
      );
}
