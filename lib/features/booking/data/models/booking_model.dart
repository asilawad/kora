import '../../../../core/constants/api_constants.dart';
import '../../../home/domain/entities/staff_ref_entity.dart';
import '../../domain/entities/booking_answer_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/booking_status.dart';

final class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.number,
    required super.code,
    required super.status,
    required super.statusLabel,
    required super.startsAt,
    required super.endsAt,
    required super.date,
    required super.dayLabel,
    required super.time,
    required super.endTime,
    required super.durationMinutes,
    required super.serviceId,
    required super.serviceName,
    required super.serviceImage,
    required super.price,
    required super.discount,
    required super.total,
    required super.currencySymbol,
    required super.paymentMethodLabel,
    required super.notes,
    required super.answersDisplay,
    required super.canCancel,
    required super.cancelIsLate,
    required super.cancelReason,
    required super.cancelledAt,
    required super.createdAt,
    required super.placeName,
    super.staff,
    super.serverMessage,
  });

  factory BookingModel.fromJson(
    Map<String, dynamic> json, {
    String? serverMessage,
  }) {
    final service = _map(json[ApiResponseKeys.service]);
    final staff = _map(json[ApiResponseKeys.staff]);
    final place = _map(json[ApiResponseKeys.place]);
    final answers = json[ApiResponseKeys.answersDisplay] as List? ?? const [];
    return BookingModel(
      id: _int(json[ApiResponseKeys.id]),
      number: json[ApiResponseKeys.number] as String,
      code: json[ApiResponseKeys.code] as String,
      status: BookingStatus.fromValue(json[ApiResponseKeys.status] as String?),
      statusLabel: json[ApiResponseKeys.statusLabel] as String,
      startsAt: json[ApiResponseKeys.startsAt] as String,
      endsAt: json[ApiResponseKeys.endsAt] as String,
      date: json[ApiResponseKeys.date] as String,
      dayLabel: json[ApiResponseKeys.dayLabel] as String,
      time: json[ApiResponseKeys.time] as String,
      endTime: json[ApiResponseKeys.endTime] as String,
      durationMinutes: _int(json[ApiResponseKeys.durationMinutes]),
      serviceId: _int(json[ApiResponseKeys.serviceId]),
      serviceName: json[ApiResponseKeys.serviceName] as String,
      serviceImage: service[ApiResponseKeys.image] as String? ?? '',
      staff: staff.isEmpty ? null : _staffFromJson(staff),
      price: json[ApiResponseKeys.price] as num,
      discount: json[ApiResponseKeys.discount] as num,
      total: json[ApiResponseKeys.total] as num,
      currencySymbol: json[ApiResponseKeys.currencySymbol] as String,
      paymentMethodLabel: json[ApiResponseKeys.paymentMethodLabel] as String,
      notes: json[ApiResponseKeys.notes] as String?,
      answersDisplay: answers
          .whereType<Map<String, dynamic>>()
          .map(BookingAnswerModel.fromJson)
          .toList(),
      canCancel: json[ApiResponseKeys.canCancel] as bool,
      cancelIsLate: json[ApiResponseKeys.cancelIsLate] as bool,
      cancelReason: json[ApiResponseKeys.cancelReason] as String?,
      cancelledAt: json[ApiResponseKeys.cancelledAt] as String?,
      createdAt: json[ApiResponseKeys.createdAt] as String,
      placeName: place[ApiResponseKeys.placeName] as String? ?? '',
      serverMessage: serverMessage,
    );
  }

  static StaffRefEntity _staffFromJson(Map<String, dynamic> json) =>
      StaffRefEntity(
        id: _int(json[ApiResponseKeys.id]),
        name: json[ApiResponseKeys.name] as String,
        title: json[ApiResponseKeys.title] as String? ?? '',
        avatar: json[ApiResponseKeys.avatar] as String? ?? '',
        initials: json[ApiResponseKeys.initials] as String? ?? '',
        color: json[ApiResponseKeys.color] as String? ?? '#0A57B8',
      );

  static Map<String, dynamic> _map(Object? value) =>
      value is Map<String, dynamic> ? value : const {};

  static int _int(Object? value) => (value as num).toInt();
}

final class BookingAnswerModel extends BookingAnswerEntity {
  const BookingAnswerModel({
    required super.key,
    required super.label,
    required super.type,
    required super.display,
    super.value,
    super.unit,
  });

  factory BookingAnswerModel.fromJson(Map<String, dynamic> json) =>
      BookingAnswerModel(
        key: json[ApiResponseKeys.key] as String,
        label: json[ApiResponseKeys.label] as String,
        type: json[ApiResponseKeys.type] as String,
        value: json[ApiResponseKeys.value],
        display: json[ApiResponseKeys.display] as String,
        unit: json[ApiResponseKeys.unit] as String?,
      );
}
