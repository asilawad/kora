import '../../domain/entities/staff_ref_entity.dart';
import 'home_json_keys.dart';

final class StaffRefModel extends StaffRefEntity {
  const StaffRefModel({
    required super.id,
    required super.name,
    required super.title,
    required super.avatar,
    required super.initials,
    required super.color,
  });

  factory StaffRefModel.fromJson(Map<String, dynamic> json) => StaffRefModel(
    id: json[HomeJsonKeys.id] as int,
    name: json[HomeJsonKeys.name] as String,
    title: json[HomeJsonKeys.title] as String,
    avatar: json[HomeJsonKeys.avatar] as String,
    initials: json[HomeJsonKeys.initials] as String,
    color: json[HomeJsonKeys.color] as String,
  );
}
