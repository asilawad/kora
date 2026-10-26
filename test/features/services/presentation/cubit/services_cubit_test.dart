import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/services/domain/entities/services_page_entity.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:kora/features/services/domain/entities/service_sort.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';
import 'package:kora/features/services/domain/usecases/get_services_use_case.dart';
import 'package:kora/features/services/presentation/cubit/services_cubit.dart';
import 'package:kora/features/services/presentation/cubit/services_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_services_page.dart';

class _ServicesRepositoryMock extends Mock implements ServicesRepository {}

void main() {
  late _ServicesRepositoryMock repository;
  late ServicesPageEntity page;

  setUpAll(() async {
    registerFallbackValue(const ServicesQuery());
    final model = await loadServicesPage();
    page = ServicesPageEntity(
      items: model.items,
      page: 1,
      perPage: model.perPage,
      total: model.total,
      lastPage: model.lastPage,
    );
  });

  setUp(() {
    repository = _ServicesRepositoryMock();
  });

  blocTest<ServicesCubit, ServicesState>(
    'init loads the first page',
    build: () {
      when(
        () => repository.getServices(any()),
      ).thenAnswer((_) async => Success(page));
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>()
          .having(
            (state) => state.status,
            'loaded',
            ServicesStatus.loaded,
          )
          .having((state) => state.items.length, 'items', 10),
    ],
  );

  blocTest<ServicesCubit, ServicesState>(
    'debounces search and requests the changed query',
    build: () {
      when(
        () => repository.getServices(any()),
      ).thenAnswer((_) async => Success(page));
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) => cubit.onSearchChanged('court'),
    wait: ServicesCubit.searchDebounce + const Duration(milliseconds: 20),
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.query.search,
        'search',
        'court',
      ).having(
        (state) => state.status,
        'status',
        ServicesStatus.loading,
      ),
      isA<ServicesState>().having(
        (state) => state.status,
        'loaded',
        ServicesStatus.loaded,
      ),
    ],
    verify: (cubit) => verify(
      () => repository.getServices(const ServicesQuery(search: 'court')),
    ).called(1),
  );

  blocTest<ServicesCubit, ServicesState>(
    'category selection loads the selected category',
    build: () {
      when(
        () => repository.getServices(any()),
      ).thenAnswer((_) async => Success(page));
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) => cubit.selectCategory(46),
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>()
          .having((state) => state.query.categoryId, 'category', 46)
          .having((state) => state.status, 'loaded', ServicesStatus.loaded),
    ],
  );

  blocTest<ServicesCubit, ServicesState>(
    'sort selection loads with the selected sort',
    build: () {
      when(
        () => repository.getServices(any()),
      ).thenAnswer((_) async => Success(page));
      return ServicesCubit(GetServicesUseCase(repository));
    },
    act: (cubit) => cubit.selectSort(ServiceSort.priceAsc),
    expect: () => [
      isA<ServicesState>().having(
        (state) => state.status,
        'loading',
        ServicesStatus.loading,
      ),
      isA<ServicesState>()
          .having((state) => state.query.sort, 'sort', ServiceSort.priceAsc)
          .having((state) => state.status, 'loaded', ServicesStatus.loaded),
    ],
  );
}
