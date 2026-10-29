import '../../domain/entities/availability_day_entity.dart';
import 'service_details_json_keys.dart';

final class AvailabilityDayModel extends AvailabilityDayEntity {
  const AvailabilityDayModel({
    required super.date,
    required super.day,
    required super.label,
    required super.open,
    required super.slotsCount,
    super.firstTime,
  });

  factory AvailabilityDayModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityDayModel(
        date: json[ServiceDetailsJsonKeys.date] as String,
        day: json[ServiceDetailsJsonKeys.day] as String,
        label: json[ServiceDetailsJsonKeys.label] as String,
        open: json[ServiceDetailsJsonKeys.open] as bool,
        slotsCount: json[ServiceDetailsJsonKeys.slotsCount] as int,
        firstTime: json[ServiceDetailsJsonKeys.firstTime] as String?,
      );
}
