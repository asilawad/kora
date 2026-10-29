import 'time_slot_entity.dart';

enum SlotPeriod { morning, afternoon, evening }

abstract final class SlotPeriodBounds {
  static const int morningEndHour = 12;
  static const int eveningStartHour = 17;
}

Map<SlotPeriod, List<TimeSlotEntity>> groupSlotsByPeriod(
  List<TimeSlotEntity> slots,
) {
  final groups = <SlotPeriod, List<TimeSlotEntity>>{
    for (final period in SlotPeriod.values) period: <TimeSlotEntity>[],
  };
  for (final slot in slots) {
    final hourText = slot.time.split(':').first;
    final hour = int.tryParse(hourText);
    if (hour == null) continue;
    final period = switch (hour) {
      < SlotPeriodBounds.morningEndHour => SlotPeriod.morning,
      < SlotPeriodBounds.eveningStartHour => SlotPeriod.afternoon,
      _ => SlotPeriod.evening,
    };
    groups[period]!.add(slot);
  }
  return groups;
}
