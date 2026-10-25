import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_client.dart';
import '../models/home_data_model.dart';
import 'home_remote_data_source.dart';

final class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<HomeDataModel>> getHome() async {
    final result = await _dioClient.get(ApiConstants.home);
    // DioClient unwraps the ApiResponseKeys.data envelope before returning.
    return switch (result) {
      Success<ApiResponse>(:final data) => data.data is Map<String, dynamic>
          ? Success(
              HomeDataModel.fromJson(data.data as Map<String, dynamic>),
            )
          : const Failed(UnknownFailure()),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }
}
