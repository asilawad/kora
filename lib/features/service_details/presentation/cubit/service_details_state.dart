import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../domain/entities/availability_day_entity.dart';
import '../../domain/entities/service_details_entity.dart';
import '../../domain/entities/time_slot_entity.dart';

enum ServiceDetailsLoadStatus { initial, loading, loaded, failure }

final class ServiceDetailsState extends Equatable {
  const ServiceDetailsState({
    this.serviceId,
    this.detailsStatus = ServiceDetailsLoadStatus.initial,
    this.daysStatus = ServiceDetailsLoadStatus.initial,
    this.slotsStatus = ServiceDetailsLoadStatus.initial,
    this.details,
    this.days = const [],
    this.slots = const [],
    this.selectedStaffId,
    this.selectedDate,
    this.selectedSlot,
    this.detailsFailure,
    this.daysFailure,
    this.slotsFailure,
  });

  final int? serviceId;
  final ServiceDetailsLoadStatus detailsStatus;
  final ServiceDetailsLoadStatus daysStatus;
  final ServiceDetailsLoadStatus slotsStatus;
  final ServiceDetailsEntity? details;
  final List<AvailabilityDayEntity> days;
  final List<TimeSlotEntity> slots;
  final int? selectedStaffId;
  final String? selectedDate;
  final TimeSlotEntity? selectedSlot;
  final Failure? detailsFailure;
  final Failure? daysFailure;
  final Failure? slotsFailure;

  ServiceEntity? get service => details?.service;
  bool get canBook => selectedSlot != null;

  int? get resolvedStaffId {
    if (details?.service.staff.isEmpty != false || selectedSlot == null) {
      return null;
    }
    if (selectedStaffId != null) return selectedStaffId;
    return selectedSlot!.staff.length == 1
        ? selectedSlot!.staff.single.id
        : null;
  }

  ServiceDetailsState copyWith({
    int? serviceId,
    ServiceDetailsLoadStatus? detailsStatus,
    ServiceDetailsLoadStatus? daysStatus,
    ServiceDetailsLoadStatus? slotsStatus,
    ServiceDetailsEntity? details,
    List<AvailabilityDayEntity>? days,
    List<TimeSlotEntity>? slots,
    int? selectedStaffId,
    bool clearSelectedStaff = false,
    String? selectedDate,
    bool clearSelectedDate = false,
    TimeSlotEntity? selectedSlot,
    bool clearSelectedSlot = false,
    Failure? detailsFailure,
    bool clearDetailsFailure = false,
    Failure? daysFailure,
    bool clearDaysFailure = false,
    Failure? slotsFailure,
    bool clearSlotsFailure = false,
  }) => ServiceDetailsState(
    serviceId: serviceId ?? this.serviceId,
    detailsStatus: detailsStatus ?? this.detailsStatus,
    daysStatus: daysStatus ?? this.daysStatus,
    slotsStatus: slotsStatus ?? this.slotsStatus,
    details: details ?? this.details,
    days: days ?? this.days,
    slots: slots ?? this.slots,
    selectedStaffId: clearSelectedStaff
        ? null
        : selectedStaffId ?? this.selectedStaffId,
    selectedDate: clearSelectedDate ? null : selectedDate ?? this.selectedDate,
    selectedSlot: clearSelectedSlot ? null : selectedSlot ?? this.selectedSlot,
    detailsFailure: clearDetailsFailure
        ? null
        : detailsFailure ?? this.detailsFailure,
    daysFailure: clearDaysFailure ? null : daysFailure ?? this.daysFailure,
    slotsFailure: clearSlotsFailure ? null : slotsFailure ?? this.slotsFailure,
  );

  @override
  List<Object?> get props => [
    serviceId,
    detailsStatus,
    daysStatus,
    slotsStatus,
    details,
    days,
    slots,
    selectedStaffId,
    selectedDate,
    selectedSlot,
    detailsFailure,
    daysFailure,
    slotsFailure,
  ];
}
