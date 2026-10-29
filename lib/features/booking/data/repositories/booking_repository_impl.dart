import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/create_booking_params.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';

final class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl(this._remoteDataSource);

  final BookingRemoteDataSource _remoteDataSource;

  @override
  Future<Result<BookingEntity>> create(CreateBookingParams params) =>
      _remoteDataSource.create(_requestBody(params)).then(
        (result) => result.map<BookingEntity>((booking) => booking),
      );

  Map<String, dynamic> _requestBody(CreateBookingParams params) => {
    ApiResponseKeys.serviceId: params.serviceId,
    ApiResponseKeys.staffId: params.staffId,
    ApiResponseKeys.startsAt: params.startsAt,
    if (params.notes?.trim().isNotEmpty == true)
      ApiResponseKeys.notes: params.notes!.trim(),
    ApiResponseKeys.answers: params.answers,
    ApiResponseKeys.paymentMethod: params.paymentMethod,
  };
}
