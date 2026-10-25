import '../../../../core/error/result.dart';
import '../entities/home_data_entity.dart';

abstract interface class HomeRepository {
  Future<Result<HomeDataEntity>> getHome();
}
