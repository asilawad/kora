import '../../../../core/error/result.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../domain/entities/booking_scope.dart';
import '../../domain/entities/bookings_page_entity.dart';
import '../../domain/repositories/my_bookings_repository.dart';
import '../datasources/my_bookings_remote_data_source.dart';

final class MyBookingsRepositoryImpl implements MyBookingsRepository {
  const MyBookingsRepositoryImpl(this._remoteDataSource);

  final MyBookingsRemoteDataSource _remoteDataSource;

  @override
  Future<Result<BookingsPageEntity>> getBookings(
    BookingScope scope, {
    required int page,
  }) => _remoteDataSource.getBookings(scope, page: page).then(
    (result) => result.map<BookingsPageEntity>((model) => model),
  );

  @override
  Future<Result<BookingEntity>> cancelBooking(
    int bookingId, {
    String? reason,
  }) => _remoteDataSource
      .cancelBooking(bookingId, reason: reason)
      .then((result) => result.map<BookingEntity>((model) => model));
}
