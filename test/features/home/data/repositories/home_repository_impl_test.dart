import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/home/data/datasources/home_remote_data_source.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/data/repositories/home_repository_impl.dart';
import 'package:kora/features/home/domain/entities/home_data_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_home_model.dart';

class _MockHomeRemoteDataSource extends Mock
    implements HomeRemoteDataSource {}

void main() {
  late _MockHomeRemoteDataSource dataSource;
  late HomeRepositoryImpl repository;
  late HomeDataModel model;

  setUpAll(() async {
    model = await loadHomeModel();
  });

  setUp(() {
    dataSource = _MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(dataSource);
  });

  test('maps a successful model result to the domain entity', () async {
    when(() => dataSource.getHome()).thenAnswer((_) async => Success(model));

    final result = await repository.getHome();

    expect(result, isA<Success<HomeDataEntity>>());
    expect((result as Success<HomeDataEntity>).data, same(model));
  });

  test('preserves the same failure', () async {
    const failure = NetworkFailure();
    when(
      () => dataSource.getHome(),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await repository.getHome();

    expect(result, isA<Failed<HomeDataEntity>>());
    expect((result as Failed<HomeDataEntity>).failure, same(failure));
  });
}
