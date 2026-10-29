import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../booking/domain/entities/booking_entity.dart';

enum BookingsLoadStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  failure,
  loadMoreFailure,
}

final class BookingsTabState extends Equatable {
  const BookingsTabState({
    this.status = BookingsLoadStatus.initial,
    this.items = const [],
    this.page = 1,
    this.lastPage = 1,
    this.total = 0,
    this.failure,
    this.stale = false,
  });

  final BookingsLoadStatus status;
  final List<BookingEntity> items;
  final int page;
  final int lastPage;
  final int total;
  final Failure? failure;
  final bool stale;

  bool get hasMore => page < lastPage;

  BookingsTabState copyWith({
    BookingsLoadStatus? status,
    List<BookingEntity>? items,
    int? page,
    int? lastPage,
    int? total,
    Failure? failure,
    bool clearFailure = false,
    bool? stale,
  }) => BookingsTabState(
    status: status ?? this.status,
    items: items ?? this.items,
    page: page ?? this.page,
    lastPage: lastPage ?? this.lastPage,
    total: total ?? this.total,
    failure: clearFailure ? null : failure ?? this.failure,
    stale: stale ?? this.stale,
  );

  @override
  List<Object?> get props => [
    status,
    items,
    page,
    lastPage,
    total,
    failure,
    stale,
  ];
}
