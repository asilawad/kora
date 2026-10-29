/// Central place for every network-related constant.
/// All endpoints are relative to [ApiConstants.baseUrl].
abstract final class ApiConstants {
  static const String baseUrl = 'https://dori.toldpath.com/api/v1';
  static const String placeSlug = 'kora';

  static const String _place = '/places/$placeSlug';

  // ---------------------------------------------------------------------------
  // Endpoints
  // ---------------------------------------------------------------------------
  static const String ping = '/ping';
  static const String place = _place;
  static const String home = '$_place/home';
  static const String categories = '$_place/categories';
  static const String services = '$_place/services';
  static const String availabilityDays = '$_place/availability/days';
  static const String availabilitySlots = '$_place/availability/slots';
  static const String bookings = '$_place/bookings';
  static const String login = '$_place/auth/login';
  static const String register = '$_place/auth/register';
  static const String me = '$_place/auth/me';

  // Parameterized endpoints (documented in the Postman collection).
  static String serviceDetails(Object id) => '$services/$id';
  static String cancelBooking(Object id) => '$bookings/$id/cancel';
}

/// Query parameter keys and fixed values.
abstract final class ApiQuery {
  static const String search = 'q';
  static const String categoryId = 'category_id';
  static const String sort = 'sort';
  static const String order = 'order';
  static const String staffId = 'staff_id';
  static const String serviceId = 'service_id';
  static const String page = 'page';
  static const String perPage = 'per_page';
  static const String days = 'days';
  static const String date = 'date';
  static const String scope = 'scope';

  static const String scopeUpcoming = 'upcoming';
  static const String scopePast = 'past';
}

/// Request defaults.
abstract final class ApiConfig {
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);

  static const int defaultPerPage = 15;
  static const int defaultDaysAhead = 14;
}

/// HTTP header names and values.
abstract final class ApiHeaders {
  static const String accept = 'Accept';
  static const String acceptLanguage = 'Accept-Language';
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String json = 'application/json';
  static const String bearerPrefix = 'Bearer';
}

/// Keys of the standard response envelope.
abstract final class ApiResponseKeys {
  static const String success = 'success';
  static const String message = 'message';
  static const String data = 'data';
  static const String meta = 'meta';
  static const String error = 'error';
  static const String code = 'code';
  static const String details = 'details';
  static const String alternatives = 'alternatives';
  static const String page = 'page';
  static const String perPage = 'per_page';
  static const String total = 'total';
  static const String lastPage = 'last_page';
}

/// Known API error codes.
abstract final class ApiErrorCodes {
  static const String slotUnavailable = 'SLOT_UNAVAILABLE';
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
}
