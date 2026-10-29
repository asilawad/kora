import 'package:equatable/equatable.dart';

class BookingAnswerEntity extends Equatable {
  const BookingAnswerEntity({
    required this.key,
    required this.label,
    required this.type,
    required this.display,
    this.value,
    this.unit,
  });

  final String key;
  final String label;
  final String type;
  final Object? value;
  final String display;
  final String? unit;

  @override
  List<Object?> get props => [key, label, type, value, display, unit];
}
