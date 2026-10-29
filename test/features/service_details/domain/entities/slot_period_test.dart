import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/service_details/domain/entities/slot_period.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';

void main() {
  test('groups display times at the period boundaries', () {
    TimeSlotEntity slot(String time) => TimeSlotEntity(
      time: time,
      startsAt: '',
      endsAt: '',
      staff: const [],
      seatsLeft: 1,
    );

    final grouped = groupSlotsByPeriod([
      slot('11:45'),
      slot('12:00'),
      slot('16:45'),
      slot('17:00'),
    ]);

    expect(grouped[SlotPeriod.morning]!.single.time, '11:45');
    expect(
      grouped[SlotPeriod.afternoon]!.map((item) => item.time),
      ['12:00', '16:45'],
    );
    expect(grouped[SlotPeriod.evening]!.single.time, '17:00');
  });
}
