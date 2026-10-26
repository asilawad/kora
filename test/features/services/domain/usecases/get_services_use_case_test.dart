import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/services/domain/entities/services_page_entity.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';
import 'package:kora/features/services/domain/usecases/get_services_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _ServicesRepositoryMock extends Mock implements ServicesRepository {}

void main() {
  late _ServicesRepositoryMock repository;
  late GetServicesUseCase useCase;

  setUp(() {
    repository = _ServicesRepositoryMock();
    useCase = GetServicesUseCase(repository);
  });

  test('forwards query and result to the repository', () async {
    const query = ServicesQuery(search: 'tennis');
    const page = ServicesPageEntity(
      items: [],
      page: 1,
      perPage: ServicesQuery.defaultPerPage,
      total: 0,
      lastPage: 1,
    );
    when(
      () => repository.getServices(query),
    ).thenAnswer((_) async => const Success(page));

    final result = await useCase(query);

    expect(result.dataOrNull, same(page));
    verify(() => repository.getServices(query)).called(1);
  });

  test('forwards repository failures unchanged', () async {
    const query = ServicesQuery();
    const failure = NetworkFailure();
    when(
      () => repository.getServices(query),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await useCase(query);

    expect(result.failureOrNull, same(failure));
  });
}
