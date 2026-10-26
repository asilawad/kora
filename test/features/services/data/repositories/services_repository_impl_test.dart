import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/services/data/datasources/services_remote_data_source.dart';
import 'package:kora/features/services/data/models/services_page_model.dart';
import 'package:kora/features/services/data/repositories/services_repository_impl.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_services_page.dart';

class _ServicesRemoteDataSourceMock extends Mock
    implements ServicesRemoteDataSource {}

void main() {
  late _ServicesRemoteDataSourceMock remote;
  late ServicesRepositoryImpl repository;
  late ServicesPageModel page;

  setUpAll(() async {
    registerFallbackValue(const ServicesQuery());
    page = await loadServicesPage();
  });

  setUp(() {
    remote = _ServicesRemoteDataSourceMock();
    repository = ServicesRepositoryImpl(remote);
  });

  test('maps a successful page to the domain entity', () async {
    when(
      () => remote.getServices(any()),
    ).thenAnswer((_) async => Success(page));

    final result = await repository.getServices(const ServicesQuery());

    expect(result.dataOrNull, same(page));
  });

  test('returns the same failure instance', () async {
    const failure = NetworkFailure();
    when(
      () => remote.getServices(any()),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await repository.getServices(const ServicesQuery());

    expect(result.failureOrNull, same(failure));
  });
}
