import '../../../../core/error/result.dart';
import '../entities/booking_entity.dart';
import '../entities/create_booking_params.dart';

abstract interface class BookingRepository {
  Future<Result<BookingEntity>> create(CreateBookingParams params);
}
