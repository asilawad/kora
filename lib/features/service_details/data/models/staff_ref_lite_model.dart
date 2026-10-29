import '../../../home/data/models/home_json_keys.dart';
import '../../domain/entities/staff_ref_lite_entity.dart';

final class StaffRefLiteModel extends StaffRefLiteEntity {
  const StaffRefLiteModel({required super.id, required super.name});

  factory StaffRefLiteModel.fromJson(Map<String, dynamic> json) =>
      StaffRefLiteModel(
        id: json[HomeJsonKeys.id] as int,
        name: json[HomeJsonKeys.name] as String,
      );
}
