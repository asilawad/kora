import '../../../../core/error/result.dart';
import '../models/availability_day_model.dart';
import '../models/service_details_model.dart';
import '../models/time_slot_model.dart';

abstract interface class ServiceDetailsRemoteDataSource {
  Future<Result<ServiceDetailsModel>> getDetails(int serviceId);

  Future<Result<List<AvailabilityDayModel>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  });

  Future<Result<List<TimeSlotModel>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  });
}
