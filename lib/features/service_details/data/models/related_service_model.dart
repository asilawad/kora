import '../../../home/data/models/home_json_keys.dart';
import '../../domain/entities/related_service_entity.dart';

final class RelatedServiceModel extends RelatedServiceEntity {
  const RelatedServiceModel({
    required super.id,
    required super.name,
    required super.thumb,
    required super.durationMinutes,
    required super.finalPrice,
    required super.price,
    super.salePrice,
    super.discountPercent,
  });

  factory RelatedServiceModel.fromJson(Map<String, dynamic> json) =>
      RelatedServiceModel(
        id: json[HomeJsonKeys.id] as int,
        name: json[HomeJsonKeys.name] as String,
        thumb: json[HomeJsonKeys.thumb] as String,
        durationMinutes: json[HomeJsonKeys.durationMinutes] as int,
        finalPrice: json[HomeJsonKeys.finalPrice] as num,
        price: json[HomeJsonKeys.price] as num,
        salePrice: json[HomeJsonKeys.salePrice] as num?,
        discountPercent: json[HomeJsonKeys.discountPercent] as int?,
      );
}
