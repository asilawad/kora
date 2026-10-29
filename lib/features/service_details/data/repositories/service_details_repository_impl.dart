import '../../../../core/error/result.dart';
import '../../domain/entities/availability_day_entity.dart';
import '../../domain/entities/service_details_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../../domain/repositories/service_details_repository.dart';
import '../datasources/service_details_remote_data_source.dart';
import '../models/service_details_model.dart';

final class ServiceDetailsRepositoryImpl implements ServiceDetailsRepository {
  const ServiceDetailsRepositoryImpl(this._remoteDataSource);

  final ServiceDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<Result<ServiceDetailsEntity>> getDetails(int serviceId) async =>
      _remoteDataSource.getDetails(serviceId).then(
        (result) => result.map<ServiceDetailsEntity>(_mapDetails),
      );

  @override
  Future<Result<List<AvailabilityDayEntity>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  }) async => _remoteDataSource
      .getDays(serviceId, days: days, staffId: staffId)
      .then(
        (result) => result.map<List<AvailabilityDayEntity>>(
          (items) => items,
        ),
      );

  @override
  Future<Result<List<TimeSlotEntity>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  }) async => _remoteDataSource
      .getSlots(serviceId, date: date, staffId: staffId)
      .then(
        (result) => result.map<List<TimeSlotEntity>>(
          (items) => items,
        ),
      );

  ServiceDetailsEntity _mapDetails(ServiceDetailsModel model) => model;
}
