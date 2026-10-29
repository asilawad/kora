import '../../../../core/error/result.dart';
import '../entities/service_details_entity.dart';
import '../repositories/service_details_repository.dart';

final class GetServiceDetailsUseCase {
  const GetServiceDetailsUseCase(this._repository);

  final ServiceDetailsRepository _repository;

  Future<Result<ServiceDetailsEntity>> call(int serviceId) =>
      _repository.getDetails(serviceId);
}
