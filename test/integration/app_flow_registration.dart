import 'package:kora/core/di/injection.dart';
import 'package:kora/core/router/app_router.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/booking/domain/repositories/booking_repository.dart';
import 'package:kora/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:kora/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/domain/providers/place_info_provider.dart';
import 'package:kora/features/home/domain/repositories/home_repository.dart';
import 'package:kora/features/home/domain/usecases/get_home_use_case.dart';
import 'package:kora/features/home/presentation/cubit/home_cubit.dart';
import 'package:kora/features/my_bookings/domain/repositories/my_bookings_repository.dart';
import 'package:kora/features/my_bookings/domain/usecases/cancel_booking_use_case.dart';
import 'package:kora/features/my_bookings/domain/usecases/get_bookings_use_case.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_cubit.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/service_details/domain/usecases/get_availability_days_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_service_details_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_time_slots_use_case.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';
import 'package:kora/features/services/domain/usecases/get_services_use_case.dart';
import 'package:kora/features/services/presentation/cubit/services_cubit.dart';

Future<void> registerAppFlowDependencies({
  required HomeRepository homeRepository,
  required ServiceDetailsRepository detailsRepository,
  required BookingRepository bookingRepository,
  required AuthRepository authRepository,
  required MyBookingsRepository bookingsRepository,
  required ServicesRepository servicesRepository,
  required TokenStorage tokenStorage,
  required HomeDataModel home,
}) async {
  await sl.reset();
  AppRouter.router.go('/');
  sl.registerSingleton<HomeRepository>(homeRepository);
  sl.registerSingleton<ServiceDetailsRepository>(detailsRepository);
  sl.registerSingleton<BookingRepository>(bookingRepository);
  sl.registerSingleton<AuthRepository>(authRepository);
  sl.registerSingleton<MyBookingsRepository>(bookingsRepository);
  sl.registerSingleton<ServicesRepository>(servicesRepository);
  sl.registerSingleton<TokenStorage>(tokenStorage);
  sl.registerSingleton<PlaceInfoProvider>(PlaceInfoProvider()..update(home.place));
  _registerHome();
  _registerDetails();
  _registerBooking();
  _registerAuth();
  _registerMyBookings();
  _registerServices();
}

void _registerHome() {
  sl.registerLazySingleton<GetHomeUseCase>(
    () => GetHomeUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetHomeUseCase>()));
}

void _registerDetails() {
  sl.registerLazySingleton<GetServiceDetailsUseCase>(
    () => GetServiceDetailsUseCase(sl<ServiceDetailsRepository>()),
  );
  sl.registerLazySingleton<GetAvailabilityDaysUseCase>(
    () => GetAvailabilityDaysUseCase(sl<ServiceDetailsRepository>()),
  );
  sl.registerLazySingleton<GetTimeSlotsUseCase>(
    () => GetTimeSlotsUseCase(sl<ServiceDetailsRepository>()),
  );
  sl.registerFactory<ServiceDetailsCubit>(
    () => ServiceDetailsCubit(
      getDetails: sl<GetServiceDetailsUseCase>(),
      getDays: sl<GetAvailabilityDaysUseCase>(),
      getSlots: sl<GetTimeSlotsUseCase>(),
    ),
  );
}

void _registerBooking() {
  sl.registerLazySingleton<CreateBookingUseCase>(
    () => CreateBookingUseCase(sl<BookingRepository>()),
  );
  sl.registerFactory<BookingCubit>(
    () => BookingCubit(sl<CreateBookingUseCase>()),
  );
}

void _registerAuth() {
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );
  sl.registerSingleton<AuthCubit>(
    AuthCubit(
      login: sl<LoginUseCase>(),
      register: sl<RegisterUseCase>(),
      logout: sl<LogoutUseCase>(),
      getCurrentUser: sl<GetCurrentUserUseCase>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );
}

void _registerMyBookings() {
  sl.registerLazySingleton<GetBookingsUseCase>(
    () => GetBookingsUseCase(sl<MyBookingsRepository>()),
  );
  sl.registerLazySingleton<CancelBookingUseCase>(
    () => CancelBookingUseCase(sl<MyBookingsRepository>()),
  );
  sl.registerFactory<MyBookingsCubit>(
    () => MyBookingsCubit(
      getBookings: sl<GetBookingsUseCase>(),
      cancelBooking: sl<CancelBookingUseCase>(),
    ),
  );
}

void _registerServices() {
  sl.registerLazySingleton<GetServicesUseCase>(
    () => GetServicesUseCase(sl<ServicesRepository>()),
  );
  sl.registerFactory<ServicesCubit>(
    () => ServicesCubit(sl<GetServicesUseCase>()),
  );
}
