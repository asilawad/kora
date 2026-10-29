import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_state.dart';
import 'package:kora/features/service_details/domain/usecases/get_availability_days_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_service_details_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_time_slots_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_service_details_fixtures.dart';

class _RepositoryMock extends Mock implements ServiceDetailsRepository {}

void main() {
  late _RepositoryMock repository;
  late ServiceDetailsEntity details;
  late List<AvailabilityDayEntity> days;
  late List<TimeSlotEntity> slots;

  setUpAll(() async {
    details = await loadDetailsFixture('service_details_82.json');
    days = await loadDaysFixture('availability_days_82.json');
    slots = await loadSlotsFixture('availability_slots_82_any.json');
  });

  setUp(() {
    repository = _RepositoryMock();
  });

  ServiceDetailsCubit createCubit() => ServiceDetailsCubit(
    getDetails: GetServiceDetailsUseCase(repository),
    getDays: GetAvailabilityDaysUseCase(repository),
    getSlots: GetTimeSlotsUseCase(repository),
  );

  void stubSuccessfulLoad() {
    when(
      () => repository.getDetails(82),
    ).thenAnswer((_) async => Success(details));
    when(
      () => repository.getDays(82, days: ApiConfig.defaultDaysAhead),
    ).thenAnswer((_) async => Success(days));
    when(
      () => repository.getSlots(
        82,
        date: days.first.date,
      ),
    ).thenAnswer((_) async => Success(slots));
  }

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'loads details then days and slots for the first open day with slots',
    build: () {
      stubSuccessfulLoad();
      return createCubit();
    },
    act: (cubit) => cubit.load(82),
    expect: () => [
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'details loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'details loaded',
        ServiceDetailsLoadStatus.loaded,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.daysStatus,
        'days loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>()
          .having(
            (state) => state.daysStatus,
            'days loaded',
            ServiceDetailsLoadStatus.loaded,
          )
          .having((state) => state.selectedDate, 'selected date', days.first.date),
      isA<ServiceDetailsState>().having(
        (state) => state.slotsStatus,
        'slots loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>()
          .having(
            (state) => state.slotsStatus,
            'slots loaded',
            ServiceDetailsLoadStatus.loaded,
          )
          .having((state) => state.slots.length, 'slot count', 55),
    ],
    verify: (cubit) {
      verifyInOrder([
        () => repository.getDetails(82),
        () => repository.getDays(82, days: ApiConfig.defaultDaysAhead),
        () => repository.getSlots(82, date: days.first.date),
      ]);
    },
  );

  blocTest<ServiceDetailsCubit, ServiceDetailsState>(
    'retries details after a details failure',
    build: () {
      var attempts = 0;
      when(() => repository.getDetails(82)).thenAnswer((_) async {
        attempts++;
        return attempts == 1
            ? const Failed(NetworkFailure())
            : Success(details);
      });
      when(
        () => repository.getDays(82, days: ApiConfig.defaultDaysAhead),
      ).thenAnswer((_) async => Success(days));
      when(
        () => repository.getSlots(82, date: days.first.date),
      ).thenAnswer((_) async => Success(slots));
      return createCubit();
    },
    act: (cubit) async {
      await cubit.load(82);
      await cubit.retryDetails();
    },
    expect: () => [
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'failure',
        ServiceDetailsLoadStatus.failure,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.daysStatus,
        'days loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.daysStatus,
        'days loaded',
        ServiceDetailsLoadStatus.loaded,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.slotsStatus,
        'slots loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.slotsStatus,
        'slots loaded',
        ServiceDetailsLoadStatus.loaded,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'retry loading',
        ServiceDetailsLoadStatus.loading,
      ),
      isA<ServiceDetailsState>().having(
        (state) => state.detailsStatus,
        'retry loaded',
        ServiceDetailsLoadStatus.loaded,
      ),
    ],
  );
}
