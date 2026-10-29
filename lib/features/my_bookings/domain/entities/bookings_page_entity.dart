import 'package:equatable/equatable.dart';

import '../../../booking/domain/entities/booking_entity.dart';

class BookingsPageEntity extends Equatable {
  const BookingsPageEntity({
    required this.items,
    required this.page,
    required this.lastPage,
    required this.total,
  });

  final List<BookingEntity> items;
  final int page;
  final int lastPage;
  final int total;

  bool get hasMore => page < lastPage;

  @override
  List<Object?> get props => [items, page, lastPage, total];
}
