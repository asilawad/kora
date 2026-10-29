import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    password,
    passwordConfirmation,
  ];
}
