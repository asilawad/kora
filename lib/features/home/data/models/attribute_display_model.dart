import '../../domain/entities/attribute_display_entity.dart';
import 'home_json_keys.dart';

final class AttributeDisplayModel extends AttributeDisplayEntity {
  const AttributeDisplayModel({
    required super.key,
    required super.label,
    required super.display,
  });

  factory AttributeDisplayModel.fromJson(Map<String, dynamic> json) =>
      AttributeDisplayModel(
        key: json[HomeJsonKeys.key] as String,
        label: json[HomeJsonKeys.label] as String,
        display: json[HomeJsonKeys.display] as String,
      );
}
