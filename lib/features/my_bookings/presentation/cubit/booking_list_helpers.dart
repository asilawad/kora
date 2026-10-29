import '../../../booking/domain/entities/booking_entity.dart';

List<BookingEntity> appendUniqueBookings(
  List<BookingEntity> current,
  List<BookingEntity> next,
) {
  final ids = current.map((item) => item.id).toSet();
  return [...current, ...next.where((item) => ids.add(item.id))];
}

List<BookingEntity> prependUniqueBooking(
  List<BookingEntity> current,
  BookingEntity item,
) => [item, ...current.where((existing) => existing.id != item.id)];
