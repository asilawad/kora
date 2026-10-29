import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/service_details/domain/usecases/get_availability_days_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_service_details_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_time_slots_use_case.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_service_details_fixtures.dart';

class _RepositoryMock extends Mock implements ServiceDetailsRepository {}

void main() {
  late _RepositoryMock repository;
  late ServiceDetailsEntity details;
  late List<AvailabilityDayEntity> days;
  late List<TimeSlotEntity> anySlots;
  late List<TimeSlotEntity> staffSlots;
  late Completer<Result<List<TimeSlotEntity>>> oldSlots;

  setUpAll(() async {
    details = await loadDetailsFixture('service_details_82.json');
    days = await loadDaysFixture('availability_days_82.json');
    anySlots = await loadSlotsFixture('availability_slots_82_any.json');
    staffSlots = await loadSlotsFixture(
      'availability_slots_82_staff55.json',
    );
  });

  setUp(() {
    repository = _RepositoryMock();
  });

  ServiceDetailsCubit createCubit() => ServiceDetailsCubit(
    getDetails: GetServiceDetailsUseCase(repository),
    getDays: GetAvailabilityDaysUseCase(repository),
    getSlots: GetTimeSlotsUseCase(repository),
  );

  void stubDetailsAndDays() {
    when(
      () => repository.getDetails(82),
    ).thenAnswer((_) async => Success(details));
    when(
      () => repository.getDays(
        82,
        days: ApiConfig.defaultDaysAhead,
        staffId: any(named: 'staffId'),
      ),
    ).thenAnswer((_) async => Success(days));
    when(
      () => repository.getSlots(
        82,
        date: any(named: 'date'),
        staffId: any(named: 'staffId'),
      ),
    ).thenAnswer((invocation) async {
      final staffId = invocation.namedArguments[#staffId] as int?;
      return Success(staffId == null ? anySlots : staffSlots);
    });
  }

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'selecting staff reloads days and slots with the staff filter',
    build: () {
      stubDetailsAndDays();
      return createCubit();
    },
    act: (cubit) async {
      await cubit.load(82);
      await cubit.selectStaff(55);
    },
    verify: (cubit) {
      expect(cubit.state.selectedStaffId, 55);
      expect(cubit.state.slots.first.staff, hasLength(1));
      verify(
        () => repository.getDays(
          82,
          days: ApiConfig.defaultDaysAhead,
          staffId: 55,
        ),
      ).called(1);
      verify(
        () => repository.getSlots(
          82,
          date: days.first.date,
          staffId: 55,
        ),
      ).called(1);
    },
  );

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'selecting a date clears selection, and selecting a slot enables booking',
    build: () {
      stubDetailsAndDays();
      return createCubit();
    },
    act: (cubit) async {
      await cubit.load(82);
      cubit.selectSlot(anySlots.first);
      await cubit.selectDate('2026-10-30');
      cubit.selectSlot(staffSlots.first);
    },
    verify: (cubit) {
      expect(cubit.state.selectedDate, '2026-10-30');
      expect(cubit.state.canBook, isTrue);
      expect(cubit.state.resolvedStaffId, 55);
    },
  );

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'any-court selection resolves no single staff member',
    build: () {
      stubDetailsAndDays();
      return createCubit();
    },
    act: (cubit) async {
      await cubit.load(82);
      cubit.selectSlot(anySlots.first);
    },
    verify: (cubit) {
      expect(cubit.state.canBook, isTrue);
      expect(cubit.state.selectedSlot!.staff, hasLength(4));
      expect(cubit.state.resolvedStaffId, isNull);
    },
  );

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'drops slot results from an outdated date request',
    build: () {
      stubDetailsAndDays();
      oldSlots = Completer<Result<List<TimeSlotEntity>>>();
      when(
        () => repository.getSlots(
          82,
          date: any(named: 'date'),
          staffId: any(named: 'staffId'),
        ),
      ).thenAnswer((invocation) {
        final date = invocation.namedArguments[#date] as String;
        if (date == days.first.date) return Future.value(Success(anySlots));
        if (date == '2026-10-31') return oldSlots.future;
        return Future.value(Success(staffSlots));
      });
      return createCubit();
    },
    act: (cubit) async {
      await cubit.load(82);
      final previous = cubit.selectDate('2026-10-31');
      await cubit.selectDate('2026-11-01');
      oldSlots.complete(Success(anySlots));
      await previous;
    },
    verify: (cubit) {
      expect(cubit.state.selectedDate, '2026-11-01');
      expect(cubit.state.slots, staffSlots);
    },
  );
}
