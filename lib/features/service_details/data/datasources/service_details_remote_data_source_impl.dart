import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_client.dart';
import '../models/availability_day_model.dart';
import '../models/service_details_model.dart';
import '../models/time_slot_model.dart';
import 'service_details_remote_data_source.dart';

final class ServiceDetailsRemoteDataSourceImpl
    implements ServiceDetailsRemoteDataSource {
  const ServiceDetailsRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<ServiceDetailsModel>> getDetails(int serviceId) async {
    final result = await _dioClient.get(ApiConstants.serviceDetails(serviceId));
    return switch (result) {
      Success<ApiResponse>(:final data) => _parseDetails(data.data),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  @override
  Future<Result<List<AvailabilityDayModel>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  }) async {
    final result = await _dioClient.get(
      ApiConstants.availabilityDays,
      query: {
        ApiQuery.serviceId: serviceId,
        ApiQuery.days: days,
        if (staffId != null) ApiQuery.staffId: staffId,
      },
    );
    return switch (result) {
      Success<ApiResponse>(:final data) => _parseList(
        data.data,
        AvailabilityDayModel.fromJson,
      ),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  @override
  Future<Result<List<TimeSlotModel>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  }) async {
    final result = await _dioClient.get(
      ApiConstants.availabilitySlots,
      query: {
        ApiQuery.serviceId: serviceId,
        ApiQuery.date: date,
        if (staffId != null) ApiQuery.staffId: staffId,
      },
    );
    return switch (result) {
      Success<ApiResponse>(:final data) => _parseList(
        data.data,
        TimeSlotModel.fromJson,
      ),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  Result<ServiceDetailsModel> _parseDetails(Object? data) {
    if (data is! Map<String, dynamic>) return const Failed(UnknownFailure());
    try {
      return Success(ServiceDetailsModel.fromJson(data));
    } on FormatException catch (error) {
      return Failed(UnknownFailure(message: error.message));
    } on TypeError catch (error) {
      return Failed(UnknownFailure(message: error.toString()));
    }
  }

  Result<List<T>> _parseList<T>(
    Object? data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data is! List) return const Failed(UnknownFailure());
    try {
      return Success(
        data
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList(growable: false),
      );
    } on FormatException catch (error) {
      return Failed(UnknownFailure(message: error.message));
    } on TypeError catch (error) {
      return Failed(UnknownFailure(message: error.toString()));
    }
  }
}
