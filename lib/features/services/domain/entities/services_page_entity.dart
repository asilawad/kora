import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/service_entity.dart';

class ServicesPageEntity extends Equatable {
  const ServicesPageEntity({
    required this.items,
    required this.page,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });

  final List<ServiceEntity> items;
  final int page;
  final int perPage;
  final int total;
  final int lastPage;

  bool get hasMore => page < lastPage;

  @override
  List<Object?> get props => [items, page, perPage, total, lastPage];
}
