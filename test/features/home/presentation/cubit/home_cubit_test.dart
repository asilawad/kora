import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/domain/repositories/home_repository.dart';
import 'package:kora/features/home/domain/usecases/get_home_use_case.dart';
import 'package:kora/features/home/presentation/cubit/home_cubit.dart';
import 'package:kora/features/home/presentation/cubit/home_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_home_model.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late _MockHomeRepository repository;
  late HomeDataModel home;
  late Completer<Result<HomeDataModel>> refreshResult;
  var calls = 0;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  setUp(() {
    repository = _MockHomeRepository();
    calls = 0;
    refreshResult = Completer<Result<HomeDataModel>>();
  });

  HomeCubit createCubit() => HomeCubit(GetHomeUseCase(repository));

  blocTest<HomeCubit, HomeState>(
    'load emits loading and loaded states on success',
    setUp: () {
      when(
        () => repository.getHome(),
      ).thenAnswer((_) async => Success(home));
    },
    build: createCubit,
    act: (cubit) => cubit.load(),
    expect: () => [const HomeLoading(), HomeLoaded(home)],
  );

  blocTest<HomeCubit, HomeState>(
    'load emits failure when loading fails',
    setUp: () {
      when(
        () => repository.getHome(),
      ).thenAnswer((_) async => const Failed(NetworkFailure()));
    },
    build: createCubit,
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeLoading(),
      const HomeFailure(NetworkFailure()),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'category selection filters popular services and null restores all',
    setUp: () {
      when(
        () => repository.getHome(),
      ).thenAnswer((_) async => Success(home));
    },
    build: createCubit,
    act: (cubit) async {
      await cubit.load();
      cubit.selectCategory(home.categories.first.id);
      cubit.selectCategory(null);
    },
    expect: () => [
      const HomeLoading(),
      HomeLoaded(home),
      HomeLoaded(home, selectedCategoryId: home.categories.first.id),
      HomeLoaded(home),
    ],
    verify: (cubit) {
      final loaded = cubit.state as HomeLoaded;
      expect(loaded.filteredPopular, home.popular);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'refresh keeps loaded content visible until replacement data arrives',
    build: createCubit,
    setUp: () {
      when(() => repository.getHome()).thenAnswer((_) {
        calls++;
        return calls == 1
            ? Future.value(Success(home))
            : refreshResult.future;
      });
    },
    act: (cubit) async {
      await cubit.load();
      final refresh = cubit.refresh();
      expect(cubit.state, HomeLoaded(home));
      refreshResult.complete(
        Success(
          HomeDataModel(
            place: home.place,
            categories: home.categories,
            featured: home.featured,
            popular: home.popular.take(1).toList(),
            staff: home.staff,
          ),
        ),
      );
      await refresh;
    },
    expect: () => [
      const HomeLoading(),
      HomeLoaded(home),
      isA<HomeLoaded>(),
    ],
  );
}
