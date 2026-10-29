import '../../../../core/error/result.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/login_params.dart';
import '../../domain/entities/register_params.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_session_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<Result<AuthSession>> login(LoginParams params) async {
    final result = await _remoteDataSource.login(
      LoginRequestModel(params).toJson(),
    );
    return _saveSession(result);
  }

  @override
  Future<Result<AuthSession>> register(RegisterParams params) async {
    final result = await _remoteDataSource.register(
      RegisterRequestModel(params).toJson(),
    );
    return _saveSession(result);
  }

  @override
  Future<void> logout() => _tokenStorage.clear();

  @override
  Future<Result<UserEntity>> getCurrentUser() async =>
      _remoteDataSource.getCurrentUser().then(
        (result) => result.map<UserEntity>((user) => user),
      );

  Future<Result<AuthSession>> _saveSession(
    Result<AuthSessionModel> result,
  ) async => switch (result) {
    Success<AuthSessionModel>(:final data) => _persist(data),
    Failed<AuthSessionModel>(:final failure) => Failed(failure),
  };

  Future<Result<AuthSession>> _persist(AuthSessionModel session) async {
    await _tokenStorage.save(session.token);
    return Success(session);
  }
}
