import '../../../../core/error/result.dart';
import '../models/auth_session_model.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Result<AuthSessionModel>> login(Map<String, Object?> body);

  Future<Result<AuthSessionModel>> register(Map<String, Object?> body);

  Future<Result<UserModel>> getCurrentUser();
}
