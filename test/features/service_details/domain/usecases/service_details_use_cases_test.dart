import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/service_details/domain/usecases/get_availability_days_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_service_details_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_time_slots_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_service_details_fixtures.dart';

class _RepositoryMock extends Mock implements ServiceDetailsRepository {}

void main() {
  late _RepositoryMock repository;

  setUpAll(() {
    repository = _RepositoryMock();
  });

  test('details use case forwards service id', () async {
    final details = await loadDetailsFixture('service_details_82.json');
    when(
      () => repository.getDetails(82),
    ).thenAnswer((_) async => Success(details));

    final result = await GetServiceDetailsUseCase(repository)(82);

    expect(result.dataOrNull, isA<ServiceDetailsEntity>());
    verify(() => repository.getDetails(82)).called(1);
  });

  test('days use case forwards window and optional staff', () async {
    final days = await loadDaysFixture('availability_days_82.json');
    when(
      () => repository.getDays(82, days: 14, staffId: 55),
    ).thenAnswer((_) async => Success(days));

    final result = await GetAvailabilityDaysUseCase(repository)(
      82,
      days: 14,
      staffId: 55,
    );

    expect(result.dataOrNull, isA<List<AvailabilityDayEntity>>());
  });

  test('slots use case forwards date and optional staff', () async {
    final slots = await loadSlotsFixture('availability_slots_82_staff55.json');
    when(
      () => repository.getSlots(82, date: '2026-10-30', staffId: 55),
    ).thenAnswer((_) async => Success(slots));

    final result = await GetTimeSlotsUseCase(repository)(
      82,
      date: '2026-10-30',
      staffId: 55,
    );

    expect(result.dataOrNull, isA<List<TimeSlotEntity>>());
  });
}
