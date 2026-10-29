import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/availability_day_entity.dart';
import '../../domain/entities/service_details_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../../domain/usecases/get_availability_days_use_case.dart';
import '../../domain/usecases/get_service_details_use_case.dart';
import '../../domain/usecases/get_time_slots_use_case.dart';
import 'service_details_state.dart';

final class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit({
    required GetServiceDetailsUseCase getDetails,
    required GetAvailabilityDaysUseCase getDays,
    required GetTimeSlotsUseCase getSlots,
  }) : _getDetails = getDetails,
       _getDays = getDays,
       _getSlots = getSlots,
       super(const ServiceDetailsState());

  final GetServiceDetailsUseCase _getDetails;
  final GetAvailabilityDaysUseCase _getDays;
  final GetTimeSlotsUseCase _getSlots;
  int _detailsRequestId = 0;
  int _daysRequestId = 0;
  int _slotsRequestId = 0;

  Future<void> load(int serviceId) async {
    _daysRequestId++;
    _slotsRequestId++;
    emit(
      ServiceDetailsState(
        serviceId: serviceId,
        detailsStatus: ServiceDetailsLoadStatus.loading,
        daysStatus: ServiceDetailsLoadStatus.initial,
        slotsStatus: ServiceDetailsLoadStatus.initial,
      ),
    );
    await retryDetails();
    if (isClosed || state.serviceId != serviceId) return;
    await retryDays();
  }

  Future<void> retryDetails() async {
    final serviceId = state.serviceId;
    if (serviceId == null) return;
    final requestId = ++_detailsRequestId;
    emit(
      state.copyWith(
        detailsStatus: ServiceDetailsLoadStatus.loading,
        clearDetailsFailure: true,
      ),
    );
    final result = await _getDetails(serviceId);
    if (isClosed || requestId != _detailsRequestId) return;
    switch (result) {
      case Success<ServiceDetailsEntity>(:final data):
        emit(
          state.copyWith(
            details: data,
            detailsStatus: ServiceDetailsLoadStatus.loaded,
            clearDetailsFailure: true,
          ),
        );
      case Failed<ServiceDetailsEntity>(:final failure):
        emit(
          state.copyWith(
            detailsStatus: ServiceDetailsLoadStatus.failure,
            detailsFailure: failure,
          ),
        );
    }
  }

  Future<void> retryDays() async {
    final serviceId = state.serviceId;
    if (serviceId == null) return;
    final requestId = ++_daysRequestId;
    _slotsRequestId++;
    emit(
      state.copyWith(
        daysStatus: ServiceDetailsLoadStatus.loading,
        clearDaysFailure: true,
        clearSlotsFailure: true,
        clearSelectedSlot: true,
        slots: const [],
        slotsStatus: ServiceDetailsLoadStatus.initial,
      ),
    );
    final result = await _getDays(
      serviceId,
      days: ApiConfig.defaultDaysAhead,
      staffId: state.selectedStaffId,
    );
    if (isClosed || requestId != _daysRequestId) return;
    switch (result) {
      case Success<List<AvailabilityDayEntity>>(:final data):
        final firstDay = _firstBookableDay(data);
        emit(
          state.copyWith(
            days: data,
            daysStatus: ServiceDetailsLoadStatus.loaded,
            selectedDate: firstDay?.date,
            clearSelectedDate: firstDay == null,
            clearDaysFailure: true,
          ),
        );
        if (firstDay == null) {
          emit(state.copyWith(slotsStatus: ServiceDetailsLoadStatus.loaded));
        } else {
          await _loadSlots(firstDay.date);
        }
      case Failed<List<AvailabilityDayEntity>>(:final failure):
        emit(
          state.copyWith(
            daysStatus: ServiceDetailsLoadStatus.failure,
            daysFailure: failure,
          ),
        );
    }
  }

  Future<void> selectStaff(int? staffId) async {
    emit(
      state.copyWith(
        selectedStaffId: staffId,
        clearSelectedStaff: staffId == null,
        clearSelectedSlot: true,
      ),
    );
    await retryDays();
  }

  Future<void> selectDate(String date) {
    emit(
      state.copyWith(
        selectedDate: date,
        clearSelectedSlot: true,
      ),
    );
    return _loadSlots(date);
  }

  void selectSlot(TimeSlotEntity slot) =>
      emit(state.copyWith(selectedSlot: slot));

  Future<void> retrySlots() {
    final date = state.selectedDate;
    if (date == null) return Future<void>.value();
    return _loadSlots(date);
  }

  AvailabilityDayEntity? _firstBookableDay(List<AvailabilityDayEntity> days) {
    for (final day in days) {
      if (day.open && day.slotsCount > 0) return day;
    }
    return null;
  }

  Future<void> _loadSlots(String date) async {
    final serviceId = state.serviceId;
    if (serviceId == null) return;
    final requestId = ++_slotsRequestId;
    emit(
      state.copyWith(
        slotsStatus: ServiceDetailsLoadStatus.loading,
        clearSlotsFailure: true,
        clearSelectedSlot: true,
        slots: const [],
      ),
    );
    final result = await _getSlots(
      serviceId,
      date: date,
      staffId: state.selectedStaffId,
    );
    if (isClosed || requestId != _slotsRequestId) return;
    switch (result) {
      case Success<List<TimeSlotEntity>>(:final data):
        emit(
          state.copyWith(
            slots: data,
            slotsStatus: ServiceDetailsLoadStatus.loaded,
            clearSlotsFailure: true,
          ),
        );
      case Failed<List<TimeSlotEntity>>(:final failure):
        emit(
          state.copyWith(
            slotsStatus: ServiceDetailsLoadStatus.failure,
            slotsFailure: failure,
          ),
        );
    }
  }
}
