import '../../../../core/error/result.dart';
import '../entities/booking_scope.dart';
import '../entities/bookings_page_entity.dart';
import '../repositories/my_bookings_repository.dart';

final class GetBookingsUseCase {
  const GetBookingsUseCase(this._repository);

  final MyBookingsRepository _repository;

  Future<Result<BookingsPageEntity>> call(
    BookingScope scope, {
    int page = 1,
  }) => _repository.getBookings(scope, page: page);
}
