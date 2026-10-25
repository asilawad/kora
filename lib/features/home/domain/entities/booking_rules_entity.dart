import 'package:equatable/equatable.dart';

import 'intake_field_entity.dart';

class BookingRulesEntity extends Equatable {
  const BookingRulesEntity({
    required this.windowDays,
    required this.minNoticeMinutes,
    required this.cancelBeforeHours,
    required this.maxActiveBookings,
    required this.autoConfirm,
    required this.intakeFields,
  });

  final int windowDays;
  final int minNoticeMinutes;
  final int cancelBeforeHours;
  final int maxActiveBookings;
  final bool autoConfirm;
  final List<IntakeFieldEntity> intakeFields;

  @override
  List<Object?> get props => [
    windowDays,
    minNoticeMinutes,
    cancelBeforeHours,
    maxActiveBookings,
    autoConfirm,
    intakeFields,
  ];
}
