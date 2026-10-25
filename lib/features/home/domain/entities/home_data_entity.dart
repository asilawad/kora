import 'package:equatable/equatable.dart';

import 'category_entity.dart';
import 'place_entity.dart';
import 'service_entity.dart';
import 'staff_entity.dart';

class HomeDataEntity extends Equatable {
  const HomeDataEntity({
    required this.place,
    required this.categories,
    required this.featured,
    required this.popular,
    required this.staff,
  });

  final PlaceEntity place;
  final List<CategoryEntity> categories;
  final List<ServiceEntity> featured;
  final List<ServiceEntity> popular;
  final List<StaffEntity> staff;

  @override
  List<Object?> get props => [place, categories, featured, popular, staff];
}
