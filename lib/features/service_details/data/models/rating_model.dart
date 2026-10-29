import '../../../home/data/models/home_json_keys.dart';
import '../../../home/domain/entities/rating_entity.dart';

final class RatingModel extends RatingEntity {
  const RatingModel({required super.average, required super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    average: json[HomeJsonKeys.average] as num,
    count: json[HomeJsonKeys.count] as int,
  );
}
