import 'package:equatable/equatable.dart';

class IntakeFieldEntity extends Equatable {
  const IntakeFieldEntity({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.type,
    this.unit,
  });

  final String key;
  final String labelAr;
  final String labelEn;
  final String type;
  final String? unit;

  @override
  List<Object?> get props => [key, labelAr, labelEn, type, unit];
}
