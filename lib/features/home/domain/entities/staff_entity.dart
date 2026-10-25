import 'package:equatable/equatable.dart';

import 'opening_day_entity.dart';
import 'rating_entity.dart';

class StaffEntity extends Equatable {
  const StaffEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.avatar,
    required this.initials,
    required this.color,
    required this.usesPlaceHours,
    required this.hours,
    required this.rating,
  });

  final int id;
  final String name;
  final String title;
  final String avatar;
  final String initials;
  final String color;
  final bool usesPlaceHours;
  final List<OpeningDayEntity> hours;
  final RatingEntity rating;

  @override
  List<Object?> get props => [
    id,
    name,
    title,
    avatar,
    initials,
    color,
    usesPlaceHours,
    hours,
    rating,
  ];
}
