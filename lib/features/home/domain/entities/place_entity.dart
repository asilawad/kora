import 'package:equatable/equatable.dart';

import 'booking_rules_entity.dart';
import 'intake_field_entity.dart';
import 'opening_day_entity.dart';
import 'place_contact_entity.dart';
import 'rating_entity.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    required this.cover,
    required this.currency,
    required this.currencySymbol,
    required this.timezone,
    required this.openNow,
    required this.labels,
    required this.contact,
    required this.openingHours,
    required this.rating,
    required this.bookingRules,
    required this.intakeFields,
    this.description,
  });

  final int id;
  final String name;
  final String slug;
  final String? description;
  final String logo;
  final String cover;
  final String currency;
  final String currencySymbol;
  final String timezone;
  final bool openNow;
  final Map<String, String> labels;
  final PlaceContactEntity contact;
  final List<OpeningDayEntity> openingHours;
  final RatingEntity rating;
  final BookingRulesEntity bookingRules;
  final List<IntakeFieldEntity> intakeFields;

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    description,
    logo,
    cover,
    currency,
    currencySymbol,
    timezone,
    openNow,
    labels,
    contact,
    openingHours,
    rating,
    bookingRules,
    intakeFields,
  ];
}
