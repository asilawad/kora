import '../../domain/entities/opening_day_entity.dart';
import 'home_json_keys.dart';

final class OpeningDayModel extends OpeningDayEntity {
  const OpeningDayModel({
    required super.day,
    required super.label,
    required super.open,
    required super.ranges,
  });

  factory OpeningDayModel.fromJson(Map<String, dynamic> json) =>
      OpeningDayModel(
        day: json[HomeJsonKeys.day] as String,
        label: json[HomeJsonKeys.label] as String,
        open: json[HomeJsonKeys.open] as bool,
        ranges: List<String>.from(json[HomeJsonKeys.ranges] as List),
      );
}
