import 'package:equatable/equatable.dart';

import 'reliability_entity.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.roleLabel,
    required this.initials,
    required this.isActive,
    required this.lastLoginAt,
    required this.createdAt,
    this.avatar,
    this.cohort,
    this.reliability,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String roleLabel;
  final String initials;
  final bool isActive;
  final String lastLoginAt;
  final String createdAt;
  final String? avatar;
  final String? cohort;
  final ReliabilityEntity? reliability;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    role,
    roleLabel,
    initials,
    isActive,
    lastLoginAt,
    createdAt,
    avatar,
    cohort,
    reliability,
  ];
}
