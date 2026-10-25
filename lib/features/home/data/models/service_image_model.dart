import '../../domain/entities/service_image_entity.dart';
import 'home_json_keys.dart';

final class ServiceImageModel extends ServiceImageEntity {
  const ServiceImageModel({
    required super.path,
    required super.url,
    required super.thumb,
  });

  factory ServiceImageModel.fromJson(Map<String, dynamic> json) =>
      ServiceImageModel(
        path: json[HomeJsonKeys.path] as String,
        url: json[HomeJsonKeys.url] as String,
        thumb: json[HomeJsonKeys.thumb] as String,
      );
}
