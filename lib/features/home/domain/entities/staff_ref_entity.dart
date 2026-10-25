import 'package:equatable/equatable.dart';

class StaffRefEntity extends Equatable {
  const StaffRefEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.avatar,
    required this.initials,
    required this.color,
  });

  final int id;
  final String name;
  final String title;
  final String avatar;
  final String initials;
  final String color;

  @override
  List<Object?> get props => [id, name, title, avatar, initials, color];
}
