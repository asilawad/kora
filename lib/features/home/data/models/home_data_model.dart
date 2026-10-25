import '../../domain/entities/home_data_entity.dart';
import 'category_model.dart';
import 'home_json_keys.dart';
import 'place_model.dart';
import 'service_model.dart';
import 'staff_model.dart';

final class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required super.place,
    required super.categories,
    required super.featured,
    required super.popular,
    required super.staff,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    place: PlaceModel.fromJson(
      json[HomeJsonKeys.place] as Map<String, dynamic>,
    ),
    categories: (json[HomeJsonKeys.categories] as List)
        .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
        .toList(),
    featured: (json[HomeJsonKeys.featured] as List)
        .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
        .toList(),
    popular: (json[HomeJsonKeys.popular] as List)
        .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
        .toList(),
    staff: (json[HomeJsonKeys.staff] as List)
        .map((item) => StaffModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
}
