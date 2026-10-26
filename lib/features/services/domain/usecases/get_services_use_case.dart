import '../../../../core/error/result.dart';
import '../entities/services_page_entity.dart';
import '../entities/services_query.dart';
import '../repositories/services_repository.dart';

final class GetServicesUseCase {
  const GetServicesUseCase(this._repository);

  final ServicesRepository _repository;

  Future<Result<ServicesPageEntity>> call(ServicesQuery query) =>
      _repository.getServices(query);
}
