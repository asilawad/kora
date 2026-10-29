import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/result.dart';
import '../models/booking_model.dart';
import 'booking_remote_data_source.dart';

final class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  const BookingRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<Result<BookingModel>> create(Map<String, dynamic> body) async {
    final result = await _client.post(ApiConstants.bookings, body: body);
    return result.map((response) {
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const FormatException('Booking response data must be an object.');
      }
      return BookingModel.fromJson(data);
    });
  }
}
