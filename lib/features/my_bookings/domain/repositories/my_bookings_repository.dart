import '../../../../core/error/result.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../entities/booking_scope.dart';
import '../entities/bookings_page_entity.dart';

abstract interface class MyBookingsRepository {
  Future<Result<BookingsPageEntity>> getBookings(
    BookingScope scope, {
    required int page,
  });

  Future<Result<BookingEntity>> cancelBooking(
    int bookingId, {
    String? reason,
  });
}
