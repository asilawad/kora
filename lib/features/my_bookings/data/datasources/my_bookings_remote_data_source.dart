import '../../../../core/error/result.dart';
import '../../../booking/data/models/booking_model.dart';
import '../models/bookings_page_model.dart';
import '../../domain/entities/booking_scope.dart';

abstract interface class MyBookingsRemoteDataSource {
  Future<Result<BookingsPageModel>> getBookings(
    BookingScope scope, {
    required int page,
  });

  Future<Result<BookingModel>> cancelBooking(
    int bookingId, {
    String? reason,
  });
}
