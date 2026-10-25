import 'package:equatable/equatable.dart';

class OpeningDayEntity extends Equatable {
  const OpeningDayEntity({
    required this.day,
    required this.label,
    required this.open,
    required this.ranges,
  });

  final String day;
  final String label;
  final bool open;
  final List<String> ranges;

  @override
  List<Object?> get props => [day, label, open, ranges];
}
