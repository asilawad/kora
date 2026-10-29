import '../../../../core/error/result.dart';
import '../entities/availability_day_entity.dart';
import '../entities/service_details_entity.dart';
import '../entities/time_slot_entity.dart';

abstract interface class ServiceDetailsRepository {
  Future<Result<ServiceDetailsEntity>> getDetails(int serviceId);

  Future<Result<List<AvailabilityDayEntity>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  });

  Future<Result<List<TimeSlotEntity>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  });
}
