import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/staff_ref_entity.dart';
import 'booking_answer_entity.dart';
import 'booking_status.dart';

class BookingEntity extends Equatable {
  const BookingEntity({
    required this.id,
    required this.number,
    required this.code,
    required this.status,
    required this.statusLabel,
    required this.startsAt,
    required this.endsAt,
    required this.date,
    required this.dayLabel,
    required this.time,
    required this.endTime,
    required this.durationMinutes,
    required this.serviceId,
    required this.serviceName,
    required this.serviceImage,
    required this.price,
    required this.discount,
    required this.total,
    required this.currencySymbol,
    required this.paymentMethodLabel,
    required this.notes,
    required this.answersDisplay,
    required this.canCancel,
    required this.cancelIsLate,
    required this.cancelReason,
    required this.cancelledAt,
    required this.createdAt,
    required this.placeName,
    this.staff,
    this.serverMessage,
  });

  final int id;
  final String number;
  final String code;
  final BookingStatus status;
  final String statusLabel;
  final String startsAt;
  final String endsAt;
  final String date;
  final String dayLabel;
  final String time;
  final String endTime;
  final int durationMinutes;
  final int serviceId;
  final String serviceName;
  final String serviceImage;
  final StaffRefEntity? staff;
  final num price;
  final num discount;
  final num total;
  final String currencySymbol;
  final String paymentMethodLabel;
  final String? notes;
  final List<BookingAnswerEntity> answersDisplay;
  final bool canCancel;
  final bool cancelIsLate;
  final String? cancelReason;
  final String? cancelledAt;
  final String createdAt;
  final String placeName;
  final String? serverMessage;

  @override
  List<Object?> get props => [
    id, number, code, status, statusLabel, startsAt, endsAt, date, dayLabel,
    time, endTime, durationMinutes, serviceId, serviceName, serviceImage,
    staff, price, discount, total, currencySymbol, paymentMethodLabel, notes,
    answersDisplay, canCancel, cancelIsLate, cancelReason, cancelledAt,
    createdAt, placeName, serverMessage,
  ];
}
