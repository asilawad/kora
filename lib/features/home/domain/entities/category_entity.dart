import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.sortOrder,
    required this.servicesCount,
  });

  final int id;
  final String name;
  final String icon;
  final String image;
  final int sortOrder;
  final int servicesCount;

  @override
  List<Object?> get props => [id, name, icon, image, sortOrder, servicesCount];
}
