import '../../domain/entities/service_attributes_entity.dart';
import 'home_json_keys.dart';

final class ServiceAttributesModel extends ServiceAttributesEntity {
  const ServiceAttributesModel({super.sport, super.players, super.lighting});

  factory ServiceAttributesModel.fromJson(Map<String, dynamic> json) =>
      ServiceAttributesModel(
        sport: json[HomeJsonKeys.sport] as String?,
        players: json[HomeJsonKeys.players] as num?,
        lighting: json[HomeJsonKeys.lighting] as bool?,
      );
}
