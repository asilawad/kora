import '../../../../core/error/result.dart';
import '../entities/booking_entity.dart';
import '../entities/create_booking_params.dart';
import '../repositories/booking_repository.dart';

final class CreateBookingUseCase {
  const CreateBookingUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingEntity>> call(CreateBookingParams params) =>
      _repository.create(params);
}
