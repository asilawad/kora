import '../../../../core/error/result.dart';
import '../entities/availability_day_entity.dart';
import '../repositories/service_details_repository.dart';

final class GetAvailabilityDaysUseCase {
  const GetAvailabilityDaysUseCase(this._repository);

  final ServiceDetailsRepository _repository;

  Future<Result<List<AvailabilityDayEntity>>> call(
    int serviceId, {
    required int days,
    int? staffId,
  }) => _repository.getDays(serviceId, days: days, staffId: staffId);
}
