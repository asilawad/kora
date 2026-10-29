import '../../domain/entities/register_params.dart';
import '../auth_constants.dart';
import 'auth_json_keys.dart';

final class RegisterRequestModel {
  const RegisterRequestModel(this.params);

  final RegisterParams params;

  Map<String, Object?> toJson() => {
    AuthJsonKeys.name: params.name,
    AuthJsonKeys.email: params.email,
    AuthJsonKeys.phone: params.phone,
    AuthJsonKeys.password: params.password,
    AuthJsonKeys.passwordConfirmation: params.passwordConfirmation,
    AuthJsonKeys.deviceName: AuthConstants.deviceName,
  };
}
