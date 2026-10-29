import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class AuthSession extends Equatable {
  const AuthSession({required this.token, required this.user});

  final String token;
  final UserEntity user;

  @override
  List<Object?> get props => [token, user];
}
