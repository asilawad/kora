// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Kora';

  @override
  String get retry => 'Retry';

  @override
  String get errorNetwork =>
      'Unable to connect. Check your internet connection and try again.';

  @override
  String get errorTimeout => 'The request took too long. Please try again.';

  @override
  String get errorServer => 'A server error occurred. Please try again later.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorValidation => 'Please check your information and try again.';

  @override
  String get errorSlotUnavailable =>
      'This time slot is no longer available. Choose another slot.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';

  @override
  String get emptyDefaultMessage => 'There is nothing to show right now.';

  @override
  String get homeFeatured => 'Featured';

  @override
  String get homePopular => 'Most popular';

  @override
  String get homeCourts => 'Courts';

  @override
  String get homeAll => 'All';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeBookNow => 'Book now';

  @override
  String get homeOpenNow => 'Open now';

  @override
  String get homeClosed => 'Closed';

  @override
  String get homeClosedNow => 'Closed now';

  @override
  String get homeNoServices => 'There are no services in this category.';
}
