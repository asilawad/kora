import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/usecases/get_home_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHome) : super(const HomeInitial());

  final GetHomeUseCase _getHome;

  Future<void> load() async {
    emit(const HomeLoading());
    final result = await _getHome();
    switch (result) {
      case Success(:final data):
        emit(HomeLoaded(data));
      case Failed(:final failure):
        emit(HomeFailure(failure));
    }
  }

  Future<void> refresh() async {
    final result = await _getHome();
    switch (result) {
      case Success(:final data):
        final currentState = state;
        final selectedCategoryId = currentState is HomeLoaded
            ? currentState.selectedCategoryId
            : null;
        emit(HomeLoaded(data, selectedCategoryId: selectedCategoryId));
      case Failed():
        break;
    }
  }

  void selectCategory(int? id) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoaded(currentState.data, selectedCategoryId: id));
    }
  }
}
