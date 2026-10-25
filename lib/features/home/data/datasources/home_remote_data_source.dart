import '../../../../core/error/result.dart';
import '../models/home_data_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<HomeDataModel>> getHome();
}
