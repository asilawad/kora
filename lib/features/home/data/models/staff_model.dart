import '../../domain/entities/opening_day_entity.dart';
import '../../domain/entities/rating_entity.dart';
import '../../domain/entities/staff_entity.dart';
import 'home_json_keys.dart';
import 'opening_day_model.dart';
import 'rating_model.dart';

final class StaffModel extends StaffEntity {
  const StaffModel({
    required super.id,
    required super.name,
    required super.title,
    required super.avatar,
    required super.initials,
    required super.color,
    required super.usesPlaceHours,
    required super.hours,
    required super.rating,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    id: json[HomeJsonKeys.id] as int,
    name: json[HomeJsonKeys.name] as String,
    title: json[HomeJsonKeys.title] as String,
    avatar: json[HomeJsonKeys.avatar] as String,
    initials: json[HomeJsonKeys.initials] as String,
    color: json[HomeJsonKeys.color] as String,
    usesPlaceHours: json[HomeJsonKeys.usesPlaceHours] as bool,
    hours: (json[HomeJsonKeys.hours] as List)
        .map((day) => OpeningDayModel.fromJson(day as Map<String, dynamic>))
        .toList()
        .cast<OpeningDayEntity>(),
    rating: RatingModel.fromJson(
      json[HomeJsonKeys.rating] as Map<String, dynamic>,
    ),
  );
}
