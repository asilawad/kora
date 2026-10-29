import '../../../home/data/models/home_json_keys.dart';
import '../../domain/entities/time_slot_entity.dart';
import 'service_details_json_keys.dart';
import 'staff_ref_lite_model.dart';

final class TimeSlotModel extends TimeSlotEntity {
  const TimeSlotModel({
    required super.time,
    required super.startsAt,
    required super.endsAt,
    required super.staff,
    required super.seatsLeft,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    final rawStaff = json[HomeJsonKeys.staff] as List;
    return TimeSlotModel(
      time: json[ServiceDetailsJsonKeys.time] as String,
      startsAt: json[ServiceDetailsJsonKeys.startsAt] as String,
      endsAt: json[ServiceDetailsJsonKeys.endsAt] as String,
      staff: rawStaff
          .map(
            (item) =>
                StaffRefLiteModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(growable: false),
      seatsLeft: json[ServiceDetailsJsonKeys.seatsLeft] as int,
    );
  }
}
