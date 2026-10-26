import '../../../../core/error/result.dart';
import '../../domain/entities/services_page_entity.dart';
import '../../domain/entities/services_query.dart';
import '../../domain/repositories/services_repository.dart';
import '../datasources/services_remote_data_source.dart';

final class ServicesRepositoryImpl implements ServicesRepository {
  const ServicesRepositoryImpl(this._remoteDataSource);

  final ServicesRemoteDataSource _remoteDataSource;

  @override
  Future<Result<ServicesPageEntity>> getServices(ServicesQuery query) async =>
      _remoteDataSource.getServices(query).then(
        (result) => result.map<ServicesPageEntity>((model) => model),
      );
}
