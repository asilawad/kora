import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/service_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded(this.data, {this.selectedCategoryId});

  final HomeDataEntity data;
  final int? selectedCategoryId;

  List<ServiceEntity> get filteredPopular => selectedCategoryId == null
      ? data.popular
      : data.popular
            .where(
              (service) => service.category.id == selectedCategoryId,
            )
            .toList(growable: false);

  @override
  List<Object?> get props => [data, selectedCategoryId];
}

final class HomeFailure extends HomeState {
  const HomeFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
