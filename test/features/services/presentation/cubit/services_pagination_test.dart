import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/services/domain/entities/services_page_entity.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';
import 'package:kora/features/services/domain/usecases/get_services_use_case.dart';
import 'package:kora/features/services/presentation/cubit/services_cubit.dart';
import 'package:kora/features/services/presentation/cubit/services_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_services_page.dart';

class _ServicesRepositoryMock extends Mock implements ServicesRepository {}

void main() {
  late _ServicesRepositoryMock repository;
  late ServicesPageEntity firstPage;
  late ServicesPageEntity secondPage;
  late Completer<Result<ServicesPageEntity>> oldRequest;

  setUpAll(() async {
    registerFallbackValue(const ServicesQuery());
    final model = await loadServicesPage();
    firstPage = ServicesPageEntity(
      items: [model.items.first],
      page: 1,
      perPage: model.perPage,
      total: 20,
      lastPage: 2,
    );
    secondPage = ServicesPageEntity(
      items: [model.items.first, model.items[1]],
      page: 2,
      perPage: model.perPage,
      total: 20,
      lastPage: 2,
    );
  });

  setUp(() {
    repository = _ServicesRepositoryMock();
  });

  blocTest<ServicesCubit, ServicesState>(
    'appends only new ids on load more',
    build: () {
      var calls = 0;
      when(() => repository.getServices(any())).thenAnswer((_) async {
        calls++;
        return Success(calls == 1 ? firstPage : secondPage);
      });
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) async {
      await cubit.init();
      await cubit.loadMore();
    },
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>().having(
        (state) => state.status,
        'loaded',
        ServicesStatus.loaded,
      ),
      isA<ServicesState>().having(
        (state) => state.status,
        'loadingMore',
        ServicesStatus.loadingMore,
      ),
      isA<ServicesState>()
          .having((state) => state.items.length, 'unique items', 2)
          .having((state) => state.query.page, 'page', 2),
    ],
  );

  blocTest<ServicesCubit, ServicesState>(
    'ignores load more at last page',
    build: () {
      final page = ServicesPageEntity(
        items: firstPage.items,
        page: 1,
        perPage: firstPage.perPage,
        total: firstPage.total,
        lastPage: 1,
      );
      when(
        () => repository.getServices(any()),
      ).thenAnswer((_) async => Success(page));
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) async {
      await cubit.init();
      await cubit.loadMore();
    },
    verify: (cubit) =>
        verify(() => repository.getServices(any())).called(1),
  );

  blocTest<ServicesCubit, ServicesState>(
    'keeps items after load more failure and retries next page',
    build: () {
      var calls = 0;
      when(() => repository.getServices(any())).thenAnswer((_) async {
        calls++;
        if (calls == 1) return Success(firstPage);
        if (calls == 2) return const Failed(NetworkFailure());
        return Success(secondPage);
      });
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) async {
      await cubit.init();
      await cubit.loadMore();
      await cubit.retry();
    },
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>().having(
        (state) => state.status,
        'loaded',
        ServicesStatus.loaded,
      ),
      isA<ServicesState>().having(
        (state) => state.status,
        'loadingMore',
        ServicesStatus.loadingMore,
      ),
      isA<ServicesState>()
          .having(
            (state) => state.status,
            'load more failure',
            ServicesStatus.loadMoreFailure,
          )
          .having((state) => state.items.length, 'retained items', 1),
      isA<ServicesState>().having(
        (state) => state.status,
        'loadingMore',
        ServicesStatus.loadingMore,
      ),
      isA<ServicesState>()
          .having((state) => state.status, 'loaded', ServicesStatus.loaded)
          .having((state) => state.items.length, 'appended items', 2),
    ],
  );

  blocTest<ServicesCubit, ServicesState>(
    'drops outdated initial response after search starts',
    build: () {
      oldRequest = Completer<Result<ServicesPageEntity>>();
      when(() => repository.getServices(any())).thenAnswer((invocation) {
        final query = invocation.positionalArguments.first as ServicesQuery;
        return query.search.isEmpty
            ? oldRequest.future
            : Future.value(Success(firstPage));
      });
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) async {
      final initialRequest = cubit.init();
      cubit.onSearchChanged('fresh');
      await Future<void>.delayed(
        ServicesCubit.searchDebounce + const Duration(milliseconds: 20),
      );
      oldRequest.complete(Success(firstPage));
      await initialRequest;
    },
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>().having(
        (state) => state.query.search,
        'search',
        'fresh',
      ),
      isA<ServicesState>()
          .having((state) => state.query.search, 'search', 'fresh')
          .having((state) => state.status, 'loaded', ServicesStatus.loaded),
    ],
  );
}
