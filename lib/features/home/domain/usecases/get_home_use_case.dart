import '../../../../core/error/result.dart';
import '../entities/home_data_entity.dart';
import '../repositories/home_repository.dart';

final class GetHomeUseCase {
  const GetHomeUseCase(this._repository);

  final HomeRepository _repository;

  Future<Result<HomeDataEntity>> call() => _repository.getHome();
}
