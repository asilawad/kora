import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/rating_entity.dart';
import '../../../home/domain/entities/service_entity.dart';
import 'related_service_entity.dart';

class ServiceDetailsEntity extends Equatable {
  const ServiceDetailsEntity({
    required this.service,
    required this.rating,
    required this.related,
  });

  final ServiceEntity service;
  final RatingEntity rating;
  final List<RelatedServiceEntity> related;

  @override
  List<Object?> get props => [service, rating, related];
}
