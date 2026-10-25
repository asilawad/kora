import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/home/domain/entities/home_data_entity.dart';
import 'package:kora/features/home/domain/repositories/home_repository.dart';
import 'package:kora/features/home/domain/usecases/get_home_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_home_model.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late _MockHomeRepository repository;
  late GetHomeUseCase useCase;
  late HomeDataEntity home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  setUp(() {
    repository = _MockHomeRepository();
    useCase = GetHomeUseCase(repository);
  });

  test('requests home data from the repository', () async {
    when(() => repository.getHome()).thenAnswer((_) async => Success(home));

    final result = await useCase();

    expect(result, isA<Success<HomeDataEntity>>());
    expect((result as Success<HomeDataEntity>).data, same(home));
    verify(() => repository.getHome()).called(1);
  });
}
