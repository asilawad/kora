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
}

void _registerBookingsDependencies() {}
