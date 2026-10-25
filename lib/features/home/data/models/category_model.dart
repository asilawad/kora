import '../../domain/entities/category_entity.dart';
import 'home_json_keys.dart';

final class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.image,
    required super.sortOrder,
    required super.servicesCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json[HomeJsonKeys.id] as int,
    name: json[HomeJsonKeys.name] as String,
    icon: json[HomeJsonKeys.icon] as String,
    image: json[HomeJsonKeys.image] as String,
    sortOrder: json[HomeJsonKeys.sortOrder] as int,
    servicesCount: json[HomeJsonKeys.servicesCount] as int,
  );
}
