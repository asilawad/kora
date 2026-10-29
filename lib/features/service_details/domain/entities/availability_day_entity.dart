import 'package:equatable/equatable.dart';

class AvailabilityDayEntity extends Equatable {
  const AvailabilityDayEntity({
    required this.date,
    required this.day,
    required this.label,
    required this.open,
    required this.slotsCount,
    this.firstTime,
  });

  final String date;
  final String day;
  final String label;
  final bool open;
  final int slotsCount;
  final String? firstTime;

  @override
  List<Object?> get props => [date, day, label, open, slotsCount, firstTime];
}
