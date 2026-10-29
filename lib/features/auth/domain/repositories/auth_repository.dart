import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/login_params.dart';
import '../entities/register_params.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login(LoginParams params);

  Future<Result<AuthSession>> register(RegisterParams params);

  Future<void> logout();

  Future<Result<UserEntity>> getCurrentUser();
}
