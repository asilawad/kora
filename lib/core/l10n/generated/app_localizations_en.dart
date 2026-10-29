// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationBookings => 'My Bookings';

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

  @override
  String get authLogin => 'Log in';

  @override
  String get authRegister => 'Create account';

  @override
  String get authName => 'Full name';

  @override
  String get authEmail => 'Email';

  @override
  String get authPhone => 'Phone number';

  @override
  String get authPassword => 'Password';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authDeviceName => 'Kora app';

  @override
  String get authRequired => 'This field is required.';

  @override
  String get authPhoneRequired => 'Enter a phone number.';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authPasswordMinLength => 'Password must be at least 6 characters.';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authInvalidCredentials => 'The email or password is incorrect.';

  @override
  String get authSheetTitle => 'Your Kora account';

  @override
  String get authPasswordVisibility => 'Show password';

  @override
  String get authPasswordVisibilityHidden => 'Hide password';

  @override
  String get serviceDetailsTitle => 'Service details';

  @override
  String get serviceWith => 'With whom?';

  @override
  String get serviceAnyCourt => 'Any court';

  @override
  String get serviceChooseTime => 'Choose time';

  @override
  String get periodMorning => 'Morning';

  @override
  String get periodAfternoon => 'Afternoon';

  @override
  String get periodEvening => 'Evening';

  @override
  String get serviceNoSlots => 'No times are available on this day.';

  @override
  String serviceBookAt(String time) {
    return 'Book at $time';
  }

  @override
  String get serviceChooseTimeHint => 'Choose a time to continue';

  @override
  String seatsLeft(int count) {
    return '$count seats left';
  }

  @override
  String get attributeSport => 'Sport';

  @override
  String get attributePlayers => 'Players';

  @override
  String get attributeLighting => 'Night lighting';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get relatedServices => 'Related services';

  @override
  String get serviceDescription => 'Description';

  @override
  String get serviceAttributes => 'Details';

  @override
  String serviceRatingCount(int count) {
    return '($count)';
  }

  @override
  String get bookingConfirmTitle => 'Confirm booking';

  @override
  String get bookingConfirm => 'Confirm booking';

  @override
  String get bookingCashAtVenue => 'Cash at the venue';

  @override
  String get bookingNotesHint => 'Notes (optional)';

  @override
  String bookingRulesNote(int hours, int count) {
    return 'Cancel at least $hours hours before. You can have up to $count active bookings.';
  }

  @override
  String get bookingCourt => 'Court';

  @override
  String get bookingDateTime => 'Date and time';

  @override
  String get bookingDurationLabel => 'Duration';

  @override
  String get bookingTotalPrice => 'Total';

  @override
  String bookingDuration(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get bookingPayment => 'Payment';

  @override
  String get bookingSuccessTitle => 'Booking confirmed';

  @override
  String bookingNumber(String number) {
    return 'Booking number: $number';
  }

  @override
  String bookingCode(String code) {
    return 'Booking code: $code';
  }

  @override
  String get bookingViewBookings => 'View my bookings';

  @override
  String get bookingBackHome => 'Back to home';

  @override
  String get bookingsPlaceholderTitle => 'My bookings';

  @override
  String get bookingsPlaceholderMessage => 'Your bookings will appear here.';

  @override
  String get myBookingsTitle => 'My bookings';

  @override
  String get myBookingsUpcoming => 'Upcoming';

  @override
  String get myBookingsPast => 'Past';

  @override
  String get myBookingsSignedOut => 'Sign in to view your bookings.';

  @override
  String get myBookingsLogin => 'Log in';

  @override
  String get myBookingsCancellationUnavailable =>
      'Cancellation is no longer available.';

  @override
  String get myBookingsCancel => 'Cancel booking';

  @override
  String get myBookingsCancelTitle => 'Cancel this booking?';

  @override
  String get myBookingsCancelMessage =>
      'Are you sure you want to cancel this booking?';

  @override
  String get myBookingsCancelReason => 'Reason (optional)';

  @override
  String get myBookingsCancelLateWarning =>
      'This cancellation may be considered late.';

  @override
  String get myBookingsKeepBooking => 'Keep booking';

  @override
  String get myBookingsConfirmCancel => 'Confirm cancellation';

  @override
  String get myBookingsLogout => 'Log out';

  @override
  String get myBookingsLogoutTitle => 'Log out?';

  @override
  String get myBookingsLogoutMessage =>
      'You will need to sign in again to view your bookings.';

  @override
  String get myBookingsCancelSuccess => 'Booking cancelled.';

  @override
  String get myBookingsCancelFailure => 'Could not cancel this booking.';

  @override
  String get myBookingsLoadMore => 'Load more';

  @override
  String get myBookingsStatusConfirmed => 'Confirmed';
}
