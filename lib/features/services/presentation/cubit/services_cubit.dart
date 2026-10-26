import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/services_page_entity.dart';
import '../../domain/entities/services_query.dart';
import '../../domain/entities/service_sort.dart';
import '../../domain/usecases/get_services_use_case.dart';
import '../../../home/domain/entities/service_entity.dart';
import 'services_state.dart';

final class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this._getServices) : super(const ServicesState());

  static const Duration searchDebounce = Duration(milliseconds: 400);

  final GetServicesUseCase _getServices;
  Timer? _searchTimer;
  int _requestId = 0;

  Future<void> init({int? categoryId}) {
    final query = ServicesQuery(categoryId: categoryId);
    return _fetchFirst(query);
  }

  void onSearchChanged(String search) {
    _searchTimer?.cancel();
    _requestId++;
    final query = state.query.copyWith(search: search, page: 1);
    emit(
      state.copyWith(
        status: ServicesStatus.loading,
        query: query,
        clearFailure: true,
      ),
    );
    _searchTimer = Timer(searchDebounce, () => _fetchFirst(query));
  }

  Future<void> selectCategory(int? categoryId) {
    final query = state.query.copyWith(
      categoryId: categoryId,
      clearCategory: categoryId == null,
      page: 1,
    );
    _searchTimer?.cancel();
    return _fetchFirst(query);
  }

  Future<void> selectSort(ServiceSort sort) {
    final query = state.query.copyWith(sort: sort, page: 1);
    _searchTimer?.cancel();
    return _fetchFirst(query);
  }

  Future<void> refresh() {
    _searchTimer?.cancel();
    return _fetchFirst(state.query.copyWith(page: 1));
  }

  Future<void> retry() => switch (state.status) {
    ServicesStatus.failure => refresh(),
    ServicesStatus.loadMoreFailure => loadMore(),
    _ => Future<void>.value(),
  };

  Future<void> loadMore() async {
    if (state.status == ServicesStatus.loading ||
        state.status == ServicesStatus.loadingMore ||
        state.status == ServicesStatus.failure ||
        (state.status != ServicesStatus.loaded &&
            state.status != ServicesStatus.loadMoreFailure) ||
        state.items.isEmpty ||
        !state.hasMore) {
      return;
    }
    final query = state.query.copyWith(page: state.query.page + 1);
    final requestId = ++_requestId;
    emit(state.copyWith(status: ServicesStatus.loadingMore, clearFailure: true));
    final result = await _getServices(query);
    if (isClosed || requestId != _requestId) return;
    switch (result) {
      case Success<ServicesPageEntity>(:final data):
        emit(
          state.copyWith(
            status: ServicesStatus.loaded,
            items: _appendUnique(state.items, data.items),
            query: query.copyWith(page: data.page),
            hasMore: data.hasMore,
            total: data.total,
            clearFailure: true,
          ),
        );
      case Failed<ServicesPageEntity>(:final failure):
        emit(state.copyWith(status: ServicesStatus.loadMoreFailure, failure: failure));
    }
  }

  Future<void> _fetchFirst(ServicesQuery query) async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        status: ServicesStatus.loading,
        query: query,
        clearFailure: true,
      ),
    );
    final result = await _getServices(query);
    if (isClosed || requestId != _requestId) return;
    switch (result) {
      case Success<ServicesPageEntity>(:final data):
        emit(
          state.copyWith(
            status: ServicesStatus.loaded,
            items: data.items,
            query: query.copyWith(page: data.page),
            hasMore: data.hasMore,
            total: data.total,
            clearFailure: true,
          ),
        );
      case Failed<ServicesPageEntity>(:final failure):
        emit(state.copyWith(status: ServicesStatus.failure, failure: failure));
    }
  }

  List<ServiceEntity> _appendUnique(
    List<ServiceEntity> current,
    List<ServiceEntity> next,
  ) {
    final ids = <int>{};
    final combined = <ServiceEntity>[];
    for (final item in [...current, ...next]) {
      if (ids.add(item.id)) combined.add(item);
    }
    return combined;
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
