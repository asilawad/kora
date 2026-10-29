import '../../../../core/error/result.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/providers/place_info_provider.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource, [this._placeInfoProvider]);

  final HomeRemoteDataSource _remoteDataSource;
  final PlaceInfoProvider? _placeInfoProvider;

  @override
  Future<Result<HomeDataEntity>> getHome() async {
    final result = await _remoteDataSource.getHome();
    return result.map<HomeDataEntity>((model) {
      _placeInfoProvider?.update(model.place);
      return model;
    });
  }
}
