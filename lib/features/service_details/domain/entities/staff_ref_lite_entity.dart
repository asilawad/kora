import 'package:equatable/equatable.dart';

class StaffRefLiteEntity extends Equatable {
  const StaffRefLiteEntity({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
