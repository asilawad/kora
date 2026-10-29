import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../data/datasources/my_bookings_remote_data_source.dart';
import '../data/datasources/my_bookings_remote_data_source_impl.dart';
import '../data/repositories/my_bookings_repository_impl.dart';
import '../domain/repositories/my_bookings_repository.dart';
import '../domain/usecases/cancel_booking_use_case.dart';
import '../domain/usecases/get_bookings_use_case.dart';
import '../presentation/cubit/my_bookings_cubit.dart';

void registerMyBookingsDependencies(GetIt sl) {
  sl.registerLazySingleton<MyBookingsRemoteDataSource>(
    () => MyBookingsRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<MyBookingsRepository>(
    () => MyBookingsRepositoryImpl(sl<MyBookingsRemoteDataSource>()),
  );
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
