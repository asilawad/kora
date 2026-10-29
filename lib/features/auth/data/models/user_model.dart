import '../../domain/entities/user_entity.dart';
import 'auth_json_keys.dart';
import 'reliability_model.dart';

final class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required super.roleLabel,
    required super.initials,
    required super.isActive,
    required super.lastLoginAt,
    required super.createdAt,
    super.avatar,
    super.cohort,
    super.reliability,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawReliability = json[AuthJsonKeys.reliability];
    return UserModel(
      id: json[AuthJsonKeys.id] as int,
      name: json[AuthJsonKeys.name] as String,
      email: json[AuthJsonKeys.email] as String,
      phone: json[AuthJsonKeys.phone] as String,
      role: json[AuthJsonKeys.role] as String,
      roleLabel: json[AuthJsonKeys.roleLabel] as String,
      initials: json[AuthJsonKeys.initials] as String,
      isActive: json[AuthJsonKeys.isActive] as bool,
      lastLoginAt: json[AuthJsonKeys.lastLoginAt] as String,
      createdAt: json[AuthJsonKeys.createdAt] as String,
      avatar: json[AuthJsonKeys.avatar] as String?,
      cohort: json[AuthJsonKeys.cohort] as String?,
      reliability: rawReliability is Map<String, dynamic>
          ? ReliabilityModel.fromJson(rawReliability)
          : null,
    );
  }
}
