import '../../domain/entities/booking_rules_entity.dart';
import '../../domain/entities/intake_field_entity.dart';
import 'home_json_keys.dart';
import 'intake_field_model.dart';

final class BookingRulesModel extends BookingRulesEntity {
  const BookingRulesModel({
    required super.windowDays,
    required super.minNoticeMinutes,
    required super.cancelBeforeHours,
    required super.maxActiveBookings,
    required super.autoConfirm,
    required super.intakeFields,
  });

  factory BookingRulesModel.fromJson(Map<String, dynamic> json) =>
      BookingRulesModel(
        windowDays: json[HomeJsonKeys.windowDays] as int,
        minNoticeMinutes: json[HomeJsonKeys.minNoticeMinutes] as int,
        cancelBeforeHours: json[HomeJsonKeys.cancelBeforeHours] as int,
        maxActiveBookings: json[HomeJsonKeys.maxActiveBookings] as int,
        autoConfirm: json[HomeJsonKeys.autoConfirm] as bool,
        intakeFields: (json[HomeJsonKeys.intakeFields] as List)
            .map(
              (field) => IntakeFieldModel.fromJson(
                field as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
