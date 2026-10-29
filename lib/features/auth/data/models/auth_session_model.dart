import '../../domain/entities/auth_session.dart';
import 'auth_json_keys.dart';
import 'user_model.dart';

final class AuthSessionModel extends AuthSession {
  const AuthSessionModel({required super.token, required super.user});

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      AuthSessionModel(
        token: json[AuthJsonKeys.token] as String,
        user: UserModel.fromJson(
          json[AuthJsonKeys.user] as Map<String, dynamic>,
        ),
      );
}
