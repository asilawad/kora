import '../../../home/data/models/service_model.dart';
import '../../domain/entities/service_details_entity.dart';
import 'rating_model.dart';
import 'related_service_model.dart';
import 'service_details_json_keys.dart';

final class ServiceDetailsModel extends ServiceDetailsEntity {
  const ServiceDetailsModel({
    required super.service,
    required super.rating,
    required super.related,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawRating =
        json[ServiceDetailsJsonKeys.rating] as Map<String, dynamic>;
    final rawRelated = json[ServiceDetailsJsonKeys.related] as List;
    return ServiceDetailsModel(
      service: ServiceModel.fromJson(json),
      rating: RatingModel.fromJson(rawRating),
      related: rawRelated
          .map(
            (item) => RelatedServiceModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(growable: false),
    );
  }

}
