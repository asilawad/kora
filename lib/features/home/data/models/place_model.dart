import '../../domain/entities/place_entity.dart';
import 'booking_rules_model.dart';
import 'home_json_keys.dart';
import 'opening_day_model.dart';
import 'place_contact_model.dart';
import 'rating_model.dart';

final class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.logo,
    required super.cover,
    required super.currency,
    required super.currencySymbol,
    required super.timezone,
    required super.openNow,
    required super.labels,
    required super.contact,
    required super.openingHours,
    required super.rating,
    required super.bookingRules,
    required super.intakeFields,
    super.description,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final booking = json[HomeJsonKeys.booking] as Map<String, dynamic>;
    final bookingRules = BookingRulesModel.fromJson(booking);
    return PlaceModel(
      id: json[HomeJsonKeys.id] as int,
      name: json[HomeJsonKeys.name] as String,
      slug: json[HomeJsonKeys.slug] as String,
      description: json[HomeJsonKeys.description] as String?,
      logo: json[HomeJsonKeys.logo] as String,
      cover: json[HomeJsonKeys.cover] as String,
      currency: json[HomeJsonKeys.currency] as String,
      currencySymbol: json[HomeJsonKeys.currencySymbol] as String,
      timezone: json[HomeJsonKeys.timezone] as String,
      openNow: json[HomeJsonKeys.openNow] as bool,
      labels: Map<String, String>.from(json[HomeJsonKeys.labels] as Map),
      contact: PlaceContactModel.fromJson(
        json[HomeJsonKeys.contact] as Map<String, dynamic>,
      ),
      openingHours: (json[HomeJsonKeys.openingHours] as List)
          .map(
            (day) => OpeningDayModel.fromJson(day as Map<String, dynamic>),
          )
          .toList(),
      rating: RatingModel.fromJson(
        json[HomeJsonKeys.rating] as Map<String, dynamic>,
      ),
      bookingRules: bookingRules,
      intakeFields: bookingRules.intakeFields,
    );
  }
}
