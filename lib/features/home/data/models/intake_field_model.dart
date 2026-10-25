import '../../domain/entities/intake_field_entity.dart';
import 'home_json_keys.dart';

final class IntakeFieldModel extends IntakeFieldEntity {
  const IntakeFieldModel({
    required super.key,
    required super.labelAr,
    required super.labelEn,
    required super.type,
    super.unit,
  });

  factory IntakeFieldModel.fromJson(Map<String, dynamic> json) =>
      IntakeFieldModel(
        key: json[HomeJsonKeys.key] as String,
        labelAr: json[HomeJsonKeys.labelAr] as String,
        labelEn: json[HomeJsonKeys.labelEn] as String,
        type: json[HomeJsonKeys.type] as String,
        unit: json[HomeJsonKeys.unit] as String?,
      );
}
