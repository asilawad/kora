import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/domain/entities/auth_session.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/register_params.dart';
import 'package:kora/features/auth/domain/entities/user_entity.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/auth/presentation/cubit/auth_state.dart';
import 'package:mocktail/mocktail.dart';

class _RepositoryMock extends Mock implements AuthRepository {}

class _TokenStorageMock extends Mock implements TokenStorage {}

const _user = UserEntity(
  id: 84,
  name: 'Student',
  email: 'student@example.com',
  phone: '0599000000',
  role: 'customer',
  roleLabel: 'Customer',
  initials: 'S',
  isActive: true,
  lastLoginAt: '',
  createdAt: '',
);
const _session = AuthSession(token: 'token', user: _user);
const _loginParams = LoginParams(
  email: 'student@example.com',
  password: 'Secret123',
);
const _registerParams = RegisterParams(
  name: 'Student',
  email: 'student@example.com',
  phone: '0599000000',
  password: 'Secret123',
  passwordConfirmation: 'Secret123',
);

void main() {
  late _RepositoryMock repository;
  late _TokenStorageMock storage;

  setUp(() {
    repository = _RepositoryMock();
    storage = _TokenStorageMock();
    when(() => storage.clear()).thenAnswer((_) async {});
  });

  AuthCubit createCubit() => AuthCubit(
    login: LoginUseCase(repository),
    register: RegisterUseCase(repository),
    logout: LogoutUseCase(repository),
    getCurrentUser: GetCurrentUserUseCase(repository),
    tokenStorage: storage,
  );

  blocTest<AuthCubit, AuthState>(
    'restores unauthenticated state when no token exists',
    build: () {
      when(() => storage.read()).thenAnswer((_) async => null);
      return createCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [
      const AuthState(status: AuthStatus.unauthenticated),
    ],
    verify: (_) => verifyNever(repository.getCurrentUser),
  );

  blocTest<AuthCubit, AuthState>(
    'restores an authenticated user when current-user lookup succeeds',
    build: () {
      when(() => storage.read()).thenAnswer((_) async => 'token');
      when(
        repository.getCurrentUser,
      ).thenAnswer((_) async => const Success(_user));
      return createCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [
      const AuthState(status: AuthStatus.authenticated, user: _user),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'keeps session unknown after a network failure',
    build: () {
      when(() => storage.read()).thenAnswer((_) async => 'token');
      when(
        repository.getCurrentUser,
      ).thenAnswer((_) async => const Failed(NetworkFailure()));
      return createCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [const AuthState()],
  );

  blocTest<AuthCubit, AuthState>(
    'clears token when session restore is unauthorized',
    build: () {
      when(() => storage.read()).thenAnswer((_) async => 'token');
      when(
        repository.getCurrentUser,
      ).thenAnswer((_) async => const Failed(UnauthorizedFailure()));
      return createCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [
      const AuthState(status: AuthStatus.unauthenticated),
    ],
    verify: (_) => verify(() => storage.clear()).called(1),
  );

  blocTest<AuthCubit, AuthState>(
    'authenticates after successful login',
    build: () {
      when(
        () => repository.login(_loginParams),
      ).thenAnswer((_) async => const Success(_session));
      return createCubit();
    },
    act: (cubit) => cubit.login(_loginParams),
    expect: () => [
      const AuthState(status: AuthStatus.authenticating),
      const AuthState(status: AuthStatus.authenticated, user: _user),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'exposes invalid credentials as an authentication failure',
    build: () {
      when(
        () => repository.login(_loginParams),
      ).thenAnswer(
        (_) async => const Failed(
          InvalidCredentialsFailure(message: 'Invalid credentials'),
        ),
      );
      return createCubit();
    },
    act: (cubit) => cubit.login(_loginParams),
    expect: () => [
      const AuthState(status: AuthStatus.authenticating),
      const AuthState(
        status: AuthStatus.failure,
        failure: InvalidCredentialsFailure(message: 'Invalid credentials'),
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'registers, logs out, and responds to interceptor unauthorized callback',
    build: () {
      when(
        () => repository.register(_registerParams),
      ).thenAnswer((_) async => const Success(_session));
      when(repository.logout).thenAnswer((_) async {});
      return createCubit();
    },
    act: (cubit) async {
      await cubit.register(_registerParams);
      await cubit.logout();
      cubit.handleUnauthorized();
    },
    expect: () => [
      const AuthState(status: AuthStatus.authenticating),
      const AuthState(status: AuthStatus.authenticated, user: _user),
      const AuthState(status: AuthStatus.unauthenticated),
    ],
  );
}
