import 'package:kora/core/error/result.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/domain/entities/auth_session.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/register_params.dart';
import 'package:kora/features/auth/domain/entities/user_entity.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/booking/domain/entities/booking_entity.dart';
import 'package:kora/features/booking/domain/entities/create_booking_params.dart';
import 'package:kora/features/booking/domain/repositories/booking_repository.dart';
import 'package:kora/features/home/domain/entities/home_data_entity.dart';
import 'package:kora/features/home/domain/repositories/home_repository.dart';
import 'package:kora/features/my_bookings/domain/entities/booking_scope.dart';
import 'package:kora/features/my_bookings/domain/entities/bookings_page_entity.dart';
import 'package:kora/features/my_bookings/domain/repositories/my_bookings_repository.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/services/domain/entities/services_page_entity.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';

final class FakeHomeRepository implements HomeRepository {
  FakeHomeRepository(this.current);
  Result<HomeDataEntity> current;
  final List<Result<HomeDataEntity>> next = [];
  bool _firstCall = true;

  @override
  Future<Result<HomeDataEntity>> getHome() async {
    if (_firstCall) {
      _firstCall = false;
      return current;
    }
    return next.isEmpty ? current : next.removeAt(0);
  }
}

final class FakeServiceDetailsRepository implements ServiceDetailsRepository {
  FakeServiceDetailsRepository(this.details, this.days, this.slots);
  final ServiceDetailsEntity details;
  final List<AvailabilityDayEntity> days;
  final List<TimeSlotEntity> slots;
  int detailsCalls = 0;
  int daysCalls = 0;

  @override
  Future<Result<ServiceDetailsEntity>> getDetails(int serviceId) async {
    detailsCalls++;
    return Success(details);
  }

  @override
  Future<Result<List<AvailabilityDayEntity>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  }) async {
    daysCalls++;
    return Success(this.days);
  }

  @override
  Future<Result<List<TimeSlotEntity>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  }) async => Success(slots);
}

final class FakeBookingRepository implements BookingRepository {
  FakeBookingRepository(this.current);
  Result<BookingEntity> current;

  @override
  Future<Result<BookingEntity>> create(CreateBookingParams params) async =>
      current;
}

final class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(this.session);
  final AuthSession session;

  @override
  Future<Result<AuthSession>> login(LoginParams params) async => Success(session);
  @override
  Future<Result<AuthSession>> register(RegisterParams params) async =>
      Success(session);
  @override
  Future<void> logout() async {}
  @override
  Future<Result<UserEntity>> getCurrentUser() async => Success(session.user);
}

final class FakeTokenStorage implements TokenStorage {
  String? token;
  @override
  Future<String?> read() async => token;
  @override
  Future<void> save(String value) async => token = value;
  @override
  Future<void> clear() async => token = null;
}

final class FakeMyBookingsRepository implements MyBookingsRepository {
  FakeMyBookingsRepository(this.page, this.cancelResult);
  final BookingsPageEntity page;
  Result<BookingEntity> cancelResult;

  @override
  Future<Result<BookingsPageEntity>> getBookings(
    BookingScope scope, {
    required int page,
  }) async => Success(this.page);

  @override
  Future<Result<BookingEntity>> cancelBooking(
    int bookingId, {
    String? reason,
  }) async => cancelResult;
}

final class FakeServicesRepository implements ServicesRepository {
  FakeServicesRepository(this.current);
  Result<ServicesPageEntity> current;
  final List<Result<ServicesPageEntity>> next = [];
  bool _firstCall = true;
  int calls = 0;

  @override
  Future<Result<ServicesPageEntity>> getServices(ServicesQuery query) async {
    calls++;
    if (_firstCall) {
      _firstCall = false;
      return current;
    }
    return next.isEmpty ? current : next.removeAt(0);
  }
}
