import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../domain/entities/services_query.dart';

enum ServicesStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  failure,
  loadMoreFailure,
}

final class ServicesState extends Equatable {
  const ServicesState({
    this.status = ServicesStatus.initial,
    this.items = const [],
    this.query = const ServicesQuery(),
    this.hasMore = true,
    this.total = 0,
    this.failure,
  });

  final ServicesStatus status;
  final List<ServiceEntity> items;
  final ServicesQuery query;
  final bool hasMore;
  final int total;
  final Failure? failure;

  ServicesState copyWith({
    ServicesStatus? status,
    List<ServiceEntity>? items,
    ServicesQuery? query,
    bool? hasMore,
    int? total,
    Failure? failure,
    bool clearFailure = false,
  }) => ServicesState(
    status: status ?? this.status,
    items: items ?? this.items,
    query: query ?? this.query,
    hasMore: hasMore ?? this.hasMore,
    total: total ?? this.total,
    failure: clearFailure ? null : failure ?? this.failure,
  );

  @override
  List<Object?> get props => [status, items, query, hasMore, total, failure];
}
