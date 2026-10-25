import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../constants/app_constants.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_client.dart';
import '../network/error_interceptor.dart';
import '../storage/token_storage.dart';

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

  _registerSplashDependencies();
  _registerHomeDependencies();
  _registerBookingsDependencies();
}

void _registerSplashDependencies() {}

void _registerHomeDependencies() {}

void _registerBookingsDependencies() {}
