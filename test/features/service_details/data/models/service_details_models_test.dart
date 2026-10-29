import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';

import '../../helpers/load_service_details_fixtures.dart';

void main() {
  test('service 82 details parses shared service, rating, and related items', () async {
    final details = await loadDetailsFixture('service_details_82.json');

    expect(details.service.id, 82);
    expect(details.service.staff, hasLength(4));
    expect(details.rating.average, 0);
    expect(details.rating.count, 0);
    expect(details.related, hasLength(1));
    expect(details.related.single.id, 81);
  });

  test('service 75 parses empty staff and related lists', () async {
    final details = await loadDetailsFixture('service_details_75.json');

    expect(details.service.id, 75);
    expect(details.service.staff, isEmpty);
    expect(details.related, isEmpty);
  });

  test('availability days parse all entries and optional first time', () async {
    final days = await loadDaysFixture('availability_days_82.json');

    expect(days, hasLength(14));
    expect(days.first.firstTime, isNotNull);
    expect(days.first.firstTime, isNotEmpty);
  });

  test('availability slots parse staff variants and preserve timestamps', () async {
    final anyStaff = await loadSlotsFixture('availability_slots_82_any.json');
    final oneStaff = await loadSlotsFixture(
      'availability_slots_82_staff55.json',
    );
    final noStaff = await loadSlotsFixture('availability_slots_75.json');

    expect(anyStaff, hasLength(55));
    expect(anyStaff.first.staff, hasLength(4));
    expect(oneStaff.first.staff, hasLength(1));
    expect(noStaff, hasLength(57));
    expect(noStaff.first.staff, isEmpty);
    final envelope = await loadFixture('availability_slots_82_any.json');
    final firstJson =
        (envelope[ApiResponseKeys.data] as List).first as Map<String, dynamic>;
    expect(anyStaff.first.startsAt, firstJson['starts_at']);
  });
}
