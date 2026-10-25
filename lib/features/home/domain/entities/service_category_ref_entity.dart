import 'package:equatable/equatable.dart';

class ServiceCategoryRefEntity extends Equatable {
  const ServiceCategoryRefEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  final int id;
  final String name;
  final String icon;

  @override
  List<Object?> get props => [id, name, icon];
}
