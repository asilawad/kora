import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/auth/domain/entities/auth_session.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/register_params.dart';
import 'package:kora/features/auth/domain/entities/user_entity.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _RepositoryMock extends Mock implements AuthRepository {}

void main() {
  late _RepositoryMock repository;

  setUp(() => repository = _RepositoryMock());

  test('login and registration use cases delegate parameters', () async {
    const session = AuthSession(token: 'token', user: _user);
    const login = LoginParams(email: 'test@example.com', password: 'Secret123');
    const register = RegisterParams(
      name: 'Student',
      email: 'test@example.com',
      phone: '0599000000',
      password: 'Secret123',
      passwordConfirmation: 'Secret123',
    );
    when(() => repository.login(login)).thenAnswer((_) async => const Success(session));
    when(
      () => repository.register(register),
    ).thenAnswer((_) async => const Success(session));

    expect((await LoginUseCase(repository)(login)).dataOrNull, session);
    expect((await RegisterUseCase(repository)(register)).dataOrNull, session);
  });

  test('current user and logout use cases delegate to repository', () async {
    when(
      repository.getCurrentUser,
    ).thenAnswer((_) async => const Failed(NetworkFailure()));
    when(repository.logout).thenAnswer((_) async {});

    expect(
      (await GetCurrentUserUseCase(repository)()).failureOrNull,
      isA<NetworkFailure>(),
    );
    await LogoutUseCase(repository)();
    verify(repository.getCurrentUser).called(1);
    verify(repository.logout).called(1);
  });
}

const _user = UserEntity(
  id: 1,
  name: 'Student',
  email: 'test@example.com',
  phone: '0599000000',
  role: 'customer',
  roleLabel: 'Customer',
  initials: 'S',
  isActive: true,
  lastLoginAt: '',
  createdAt: '',
);
