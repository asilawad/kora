import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_client.dart';
import '../../../booking/data/models/booking_model.dart';
import '../../domain/entities/booking_scope.dart';
import '../models/bookings_page_model.dart';
import 'my_bookings_remote_data_source.dart';

final class MyBookingsRemoteDataSourceImpl
    implements MyBookingsRemoteDataSource {
  const MyBookingsRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<Result<BookingsPageModel>> getBookings(
    BookingScope scope, {
    required int page,
  }) async {
    final result = await _client.get(
      ApiConstants.bookings,
      query: {
        ApiQuery.scope: scope.queryValue,
        ApiQuery.page: page,
      },
    );
    return result.map(
      (response) => BookingsPageModel.fromResponse(
        data: response.data,
        meta: response.meta,
      ),
    );
  }

  @override
  Future<Result<BookingModel>> cancelBooking(
    int bookingId, {
    String? reason,
  }) async {
    final trimmedReason = reason?.trim();
    final result = await _client.post(
      ApiConstants.cancelBooking(bookingId),
      body: trimmedReason == null || trimmedReason.isEmpty
          ? null
          : {ApiRequestKeys.reason: trimmedReason},
    );
    return result.map((response) {
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const FormatException('Booking response data must be an object.');
      }
      return BookingModel.fromJson(data, serverMessage: response.message);
    });
  }
}
