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

  @override
  String get servicesTitle => 'Services';

  @override
  String get searchHint => 'Search services';

  @override
  String get sortLabel => 'Sort by';

  @override
  String get sortPopular => 'Most popular';

  @override
  String get sortPriceAsc => 'Price: low to high';

  @override
  String get sortPriceDesc => 'Price: high to low';

  @override
  String get sortDurationAsc => 'Duration: shortest first';

  @override
  String get sortName => 'Name: A to Z';

  @override
  String resultsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '$count result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String get noResults => 'No services are currently available.';

  @override
  String get noResultsForSearch => 'No services match your search.';

  @override
  String get loadMoreFailed => 'Couldn\'t load more. Try again.';

  @override
  String get homeCategories => 'Categories';

  @override
  String get homeSearchHint => 'Search courts and services';
}
