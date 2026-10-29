import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../constants/app_constants.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_client.dart';
import '../network/error_interceptor.dart';
import '../storage/token_storage.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/datasources/home_remote_data_source_impl.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_use_case.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/services/data/datasources/services_remote_data_source.dart';
import '../../features/services/data/datasources/services_remote_data_source_impl.dart';
import '../../features/services/data/repositories/services_repository_impl.dart';
import '../../features/services/domain/repositories/services_repository.dart';
import '../../features/services/domain/usecases/get_services_use_case.dart';
import '../../features/services/presentation/cubit/services_cubit.dart';
import '../../features/service_details/data/datasources/service_details_remote_data_source.dart';
import '../../features/service_details/data/datasources/service_details_remote_data_source_impl.dart';
import '../../features/service_details/data/repositories/service_details_repository_impl.dart';
import '../../features/service_details/domain/repositories/service_details_repository.dart';
import '../../features/service_details/domain/usecases/get_availability_days_use_case.dart';
import '../../features/service_details/domain/usecases/get_service_details_use_case.dart';
import '../../features/service_details/domain/usecases/get_time_slots_use_case.dart';
import '../../features/service_details/presentation/cubit/service_details_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_use_case.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/logout_use_case.dart';
import '../../features/auth/domain/usecases/register_use_case.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<FlutterSecureStorage>(
    FlutterSecureStorage.new,
  );
  sl.registerLazySingleton<TokenStorage>(
    () => SecureTokenStorage(sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(sl<TokenStorage>()),
  );
  sl.registerLazySingleton<ErrorInterceptor>(ErrorInterceptor.new);
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      languageCode: AppConstants.defaultLocaleCode,
      interceptors: [sl<AuthInterceptor>(), sl<ErrorInterceptor>()],
    ),
  );

  _registerHomeDependencies();
  _registerServicesDependencies();
  _registerServiceDetailsDependencies();
  _registerAuthDependencies();
  _registerBookingsDependencies();
  sl<AuthInterceptor>().onUnauthorized =
      () => sl<AuthCubit>().handleUnauthorized();
}

void _registerHomeDependencies() {
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetHomeUseCase>(
    () => GetHomeUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetHomeUseCase>()));
}

void _registerBookingsDependencies() {}

void _registerServicesDependencies() {
  sl.registerLazySingleton<ServicesRemoteDataSource>(
    () => ServicesRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(sl<ServicesRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetServicesUseCase>(
    () => GetServicesUseCase(sl<ServicesRepository>()),
  );
  sl.registerFactory<ServicesCubit>(
    () => ServicesCubit(sl<GetServicesUseCase>()),
  );
}

void _registerServiceDetailsDependencies() {
  sl.registerLazySingleton<ServiceDetailsRemoteDataSource>(
    () => ServiceDetailsRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<ServiceDetailsRepository>(
    () => ServiceDetailsRepositoryImpl(sl<ServiceDetailsRemoteDataSource>()),
  );
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

void _registerAuthDependencies() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<TokenStorage>(),
    ),
  );
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
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      login: sl<LoginUseCase>(),
      register: sl<RegisterUseCase>(),
      logout: sl<LogoutUseCase>(),
      getCurrentUser: sl<GetCurrentUserUseCase>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );
}
