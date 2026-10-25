import '../../domain/entities/service_category_ref_entity.dart';
import 'home_json_keys.dart';

final class ServiceCategoryRefModel extends ServiceCategoryRefEntity {
  const ServiceCategoryRefModel({
    required super.id,
    required super.name,
    required super.icon,
  });

  factory ServiceCategoryRefModel.fromJson(Map<String, dynamic> json) =>
      ServiceCategoryRefModel(
        id: json[HomeJsonKeys.id] as int,
        name: json[HomeJsonKeys.name] as String,
        icon: json[HomeJsonKeys.icon] as String,
      );
}
