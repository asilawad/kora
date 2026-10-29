import '../../../../core/error/result.dart';
import '../models/booking_model.dart';

abstract interface class BookingRemoteDataSource {
  Future<Result<BookingModel>> create(Map<String, dynamic> body);
}
