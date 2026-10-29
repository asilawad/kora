import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';

enum AuthStatus {
  unknown,
  unauthenticated,
  authenticating,
  authenticated,
  failure,
}

final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.failure,
  });

  final AuthStatus status;
  final UserEntity? user;
  final Failure? failure;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;

  @override
  List<Object?> get props => [status, user, failure];
}
