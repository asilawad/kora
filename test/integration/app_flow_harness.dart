import 'dart:convert';
import 'dart:io';

import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/result.dart';
import 'app_flow_fakes.dart';
import 'app_flow_registration.dart';
import 'package:kora/features/auth/data/models/auth_session_model.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/my_bookings/data/models/bookings_page_model.dart';
import 'package:kora/features/service_details/data/models/availability_day_model.dart';
import 'package:kora/features/service_details/data/models/service_details_model.dart';
import 'package:kora/features/service_details/data/models/time_slot_model.dart';
import 'package:kora/features/services/data/models/services_page_model.dart';

final class AppFlowHarness {
  AppFlowHarness._({
    required this.homeRepository,
    required this.detailsRepository,
    required this.bookingRepository,
    required this.authRepository,
    required this.bookingsRepository,
    required this.servicesRepository,
    required this.tokenStorage,
    required this.home,
    required this.details,
    required this.days,
    required this.slots,
    required this.booking,
    required this.authSession,
    required this.bookingsPage,
    required this.servicesPage,
  });

  final FakeHomeRepository homeRepository;
  final FakeServiceDetailsRepository detailsRepository;
  final FakeBookingRepository bookingRepository;
  final FakeAuthRepository authRepository;
  final FakeMyBookingsRepository bookingsRepository;
  final FakeServicesRepository servicesRepository;
  final FakeTokenStorage tokenStorage;
  final HomeDataModel home;
  final ServiceDetailsModel details;
  final List<AvailabilityDayModel> days;
  final List<TimeSlotModel> slots;
  final BookingModel booking;
  final AuthSessionModel authSession;
  final BookingsPageModel bookingsPage;
  final ServicesPageModel servicesPage;

  static Future<AppFlowHarness> create() async {
    final home = HomeDataModel.fromJson(_data('home_response.json'));
    final details = ServiceDetailsModel.fromJson(
      _data('service_details_82.json'),
    );
    final days = _list('availability_days_82.json')
        .map(AvailabilityDayModel.fromJson)
        .toList();
    final slots = _list('availability_slots_82_staff55.json')
        .map(TimeSlotModel.fromJson)
        .toList();
    final bookingJson = _data('booking_create_success_response.json');
    final cancelJson = _data('booking_cancel_response.json')
      ..[ApiResponseKeys.id] = 2791;
    return AppFlowHarness._(
      homeRepository: FakeHomeRepository(Success(home)),
      detailsRepository: FakeServiceDetailsRepository(details, days, slots),
      bookingRepository: FakeBookingRepository(
        Success(BookingModel.fromJson(bookingJson)),
      ),
      authRepository: FakeAuthRepository(
        AuthSessionModel.fromJson(_data('auth_login_response.json')),
      ),
      bookingsRepository: FakeMyBookingsRepository(
        BookingsPageModel.fromResponse(
          data: _envelope('bookings_list_upcoming.json')[ApiResponseKeys.data],
          meta: _envelope('bookings_list_upcoming.json')[ApiResponseKeys.meta]
              as Map<String, dynamic>,
        ),
        Success(
          BookingModel.fromJson(
            cancelJson,
            serverMessage: _envelope('booking_cancel_response.json')[
                ApiResponseKeys.message] as String,
          ),
        ),
      ),
      servicesRepository: FakeServicesRepository(
        Success(
          ServicesPageModel.fromJson(
            _envelope('services_page_response.json'),
          ),
        ),
      ),
      tokenStorage: FakeTokenStorage(),
      home: home,
      details: details,
      days: days,
      slots: slots,
      booking: BookingModel.fromJson(bookingJson),
      authSession: AuthSessionModel.fromJson(
        _data('auth_login_response.json'),
      ),
      bookingsPage: BookingsPageModel.fromResponse(
        data: _envelope('bookings_list_upcoming.json')[ApiResponseKeys.data],
        meta: _envelope('bookings_list_upcoming.json')[ApiResponseKeys.meta]
            as Map<String, dynamic>,
      ),
      servicesPage: ServicesPageModel.fromJson(
        _envelope('services_page_response.json'),
      ),
    );
  }

  Future<void> register() => registerAppFlowDependencies(
      homeRepository: homeRepository,
      detailsRepository: detailsRepository,
      bookingRepository: bookingRepository,
      authRepository: authRepository,
      bookingsRepository: bookingsRepository,
      servicesRepository: servicesRepository,
      tokenStorage: tokenStorage,
      home: home,
    );
}

Map<String, dynamic> _envelope(String name) => jsonDecode(
  File('test/fixtures/$name').readAsStringSync(),
) as Map<String, dynamic>;

Map<String, dynamic> _data(String name) =>
    _envelope(name)[ApiResponseKeys.data] as Map<String, dynamic>;

List<Map<String, dynamic>> _list(String name) =>
    (_envelope(name)[ApiResponseKeys.data] as List).cast<Map<String, dynamic>>();
