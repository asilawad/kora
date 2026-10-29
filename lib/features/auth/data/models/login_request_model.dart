import '../auth_constants.dart';
import 'auth_json_keys.dart';
import '../../domain/entities/login_params.dart';

final class LoginRequestModel {
  const LoginRequestModel(this.params);

  final LoginParams params;

  Map<String, Object?> toJson() => {
    AuthJsonKeys.email: params.email,
    AuthJsonKeys.password: params.password,
    AuthJsonKeys.deviceName: AuthConstants.deviceName,
  };
}
