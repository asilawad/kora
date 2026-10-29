import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/register_params.dart';
import '../repositories/auth_repository.dart';

final class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(RegisterParams params) =>
      _repository.register(params);
}
