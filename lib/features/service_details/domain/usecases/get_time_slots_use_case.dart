import '../../../../core/error/result.dart';
import '../entities/time_slot_entity.dart';
import '../repositories/service_details_repository.dart';

final class GetTimeSlotsUseCase {
  const GetTimeSlotsUseCase(this._repository);

  final ServiceDetailsRepository _repository;

  Future<Result<List<TimeSlotEntity>>> call(
    int serviceId, {
    required String date,
    int? staffId,
  }) => _repository.getSlots(serviceId, date: date, staffId: staffId);
}
