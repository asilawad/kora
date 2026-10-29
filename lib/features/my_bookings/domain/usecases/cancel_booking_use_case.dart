import '../../../../core/error/result.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../repositories/my_bookings_repository.dart';

final class CancelBookingUseCase {
  const CancelBookingUseCase(this._repository);

  final MyBookingsRepository _repository;

  Future<Result<BookingEntity>> call(
    int bookingId, {
    String? reason,
  }) => _repository.cancelBooking(bookingId, reason: reason);
}
