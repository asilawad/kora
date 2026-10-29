import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/service_details/data/datasources/service_details_remote_data_source.dart';
import 'package:kora/features/service_details/data/models/availability_day_model.dart';
import 'package:kora/features/service_details/data/models/service_details_model.dart';
import 'package:kora/features/service_details/data/models/time_slot_model.dart';
import 'package:kora/features/service_details/data/repositories/service_details_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_service_details_fixtures.dart';

class _RemoteSourceMock extends Mock
    implements ServiceDetailsRemoteDataSource {}

void main() {
  late _RemoteSourceMock remote;
  late ServiceDetailsRepositoryImpl repository;
  late ServiceDetailsModel details;
  late List<AvailabilityDayModel> days;
  late List<TimeSlotModel> slots;

  setUpAll(() async {
    details = await loadDetailsFixture('service_details_82.json');
    days = await loadDaysFixture('availability_days_82.json');
    slots = await loadSlotsFixture('availability_slots_82_any.json');
  });

  setUp(() {
    remote = _RemoteSourceMock();
    repository = ServiceDetailsRepositoryImpl(remote);
  });

  test('maps details model into domain entity', () async {
    when(
      () => remote.getDetails(82),
    ).thenAnswer((_) async => Success(details));

    final result = await repository.getDetails(82);

    expect(result.dataOrNull?.service.id, 82);
    expect(result.dataOrNull?.rating, details.rating);
    expect(result.dataOrNull?.related, details.related);
  });

  test('maps days and slots models into domain entities', () async {
    when(
      () => remote.getDays(82, days: 14, staffId: null),
    ).thenAnswer((_) async => Success(days));
    when(
      () => remote.getSlots(82, date: '2026-10-30', staffId: 55),
    ).thenAnswer((_) async => Success(slots));

    final dayResult = await repository.getDays(82, days: 14);
    final slotResult = await repository.getSlots(
      82,
      date: '2026-10-30',
      staffId: 55,
    );

    expect(dayResult.dataOrNull, same(days));
    expect(slotResult.dataOrNull, same(slots));
  });

  test('preserves failures', () async {
    const failure = NetworkFailure();
    when(
      () => remote.getDetails(82),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await repository.getDetails(82);

    expect(result.failureOrNull, same(failure));
  });
}
