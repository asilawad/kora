import '../../../../core/constants/api_constants.dart';
import '../../../booking/data/models/booking_model.dart';
import '../../domain/entities/bookings_page_entity.dart';

final class BookingsPageModel extends BookingsPageEntity {
  const BookingsPageModel({
    required super.items,
    required super.page,
    required super.lastPage,
    required super.total,
  });

  factory BookingsPageModel.fromResponse({
    required Object? data,
    required Map<String, dynamic> meta,
  }) {
    if (data is! List) {
      throw const FormatException('Bookings response data must be a list.');
    }
    return BookingsPageModel(
      items: data
          .whereType<Map<String, dynamic>>()
          .map(BookingModel.fromJson)
          .toList(),
      page: _int(meta[ApiResponseKeys.page]),
      lastPage: _int(meta[ApiResponseKeys.lastPage]),
      total: _int(meta[ApiResponseKeys.total]),
    );
  }

  static int _int(Object? value) => (value as num?)?.toInt() ?? 1;
}
