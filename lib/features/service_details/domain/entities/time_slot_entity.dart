import 'package:equatable/equatable.dart';

import 'staff_ref_lite_entity.dart';

class TimeSlotEntity extends Equatable {
  const TimeSlotEntity({
    required this.time,
    required this.startsAt,
    required this.endsAt,
    required this.staff,
    required this.seatsLeft,
  });

  final String time;
  final String startsAt;
  final String endsAt;
  final List<StaffRefLiteEntity> staff;
  final int seatsLeft;

  @override
  List<Object?> get props => [time, startsAt, endsAt, staff, seatsLeft];
}
