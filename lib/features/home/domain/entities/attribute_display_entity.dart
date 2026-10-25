import 'package:equatable/equatable.dart';

class AttributeDisplayEntity extends Equatable {
  const AttributeDisplayEntity({
    required this.key,
    required this.label,
    required this.display,
  });

  final String key;
  final String label;
  final String display;

  @override
  List<Object?> get props => [key, label, display];
}
