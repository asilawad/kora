import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_session_model.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<AuthSessionModel>> login(Map<String, Object?> body) =>
      _sessionRequest(ApiConstants.login, body);

  @override
  Future<Result<AuthSessionModel>> register(Map<String, Object?> body) =>
      _sessionRequest(ApiConstants.register, body);

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    final result = await _dioClient.get(ApiConstants.me);
    return switch (result) {
      Success<ApiResponse>(:final data) => _parseUser(data.data),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  Future<Result<AuthSessionModel>> _sessionRequest(
    String path,
    Map<String, Object?> body,
  ) async {
    final result = await _dioClient.post(path, body: body);
    return switch (result) {
      Success<ApiResponse>(:final data) => _parseSession(data.data),
      Failed<ApiResponse>(:final failure) => Failed(failure),
    };
  }

  Result<AuthSessionModel> _parseSession(Object? data) {
    if (data is! Map<String, dynamic>) return const Failed(UnknownFailure());
    try {
      return Success(AuthSessionModel.fromJson(data));
    } on Object catch (error) {
      return Failed(UnknownFailure(message: error.toString()));
    }
  }

  Result<UserModel> _parseUser(Object? data) {
    if (data is! Map<String, dynamic>) return const Failed(UnknownFailure());
    try {
      return Success(UserModel.fromJson(data));
    } on Object catch (error) {
      return Failed(UnknownFailure(message: error.toString()));
    }
  }
}
