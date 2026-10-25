import '../../../../core/error/result.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<Result<HomeDataEntity>> getHome() async =>
      _remoteDataSource.getHome().then(
        (result) => result.map<HomeDataEntity>((model) => model),
      );
}
