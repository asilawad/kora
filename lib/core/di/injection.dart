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
  _registerBookingsDependencies();
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
