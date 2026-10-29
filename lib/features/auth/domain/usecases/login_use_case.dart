import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/login_params.dart';
import '../repositories/auth_repository.dart';

final class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(LoginParams params) =>
      _repository.login(params);
}
