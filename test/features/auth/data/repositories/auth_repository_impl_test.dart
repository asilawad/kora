import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kora/features/auth/data/models/auth_session_model.dart';
import 'package:kora/features/auth/data/models/register_request_model.dart';
import 'package:kora/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/register_params.dart';
import 'package:mocktail/mocktail.dart';

class _RemoteMock extends Mock implements AuthRemoteDataSource {}

class _TokenStorageMock extends Mock implements TokenStorage {}

Map<String, dynamic> _loginSession() =>
    (jsonDecode(File('test/fixtures/auth_login_response.json').readAsStringSync())
            as Map<String, dynamic>)['data']
        as Map<String, dynamic>;

void main() {
  late _RemoteMock remote;
  late _TokenStorageMock storage;
  late AuthRepositoryImpl repository;
  late AuthSessionModel session;

  setUpAll(() {
    registerFallbackValue(<String, Object?>{});
  });

  setUp(() {
    remote = _RemoteMock();
    storage = _TokenStorageMock();
    repository = AuthRepositoryImpl(remote, storage);
    session = AuthSessionModel.fromJson(_loginSession());
    when(() => storage.save(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
  });

  test('persists token after successful login', () async {
    when(
      () => remote.login(any()),
    ).thenAnswer((_) async => Success(session));

    final result = await repository.login(
      const LoginParams(email: 'student@example.com', password: 'Secret123'),
    );

    expect(result.dataOrNull?.token, 'TEST_TOKEN');
    verify(() => storage.save('TEST_TOKEN')).called(1);
  });

  test('does not persist token after failure', () async {
    const failure = InvalidCredentialsFailure(message: 'Invalid credentials');
    when(
      () => remote.login(any()),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await repository.login(
      const LoginParams(email: 'student@example.com', password: 'Secret123'),
    );

    expect(result.failureOrNull, same(failure));
    verifyNever(() => storage.save(any()));
  });

  test('persists token after successful registration', () async {
    when(
      () => remote.register(any()),
    ).thenAnswer((_) async => Success(session));
    const params = RegisterParams(
      name: 'Student',
      email: 'student@example.com',
      phone: '0599000000',
      password: 'Secret123',
      passwordConfirmation: 'Secret123',
    );

    final result = await repository.register(params);

    expect(result.dataOrNull?.token, 'TEST_TOKEN');
    verify(() => storage.save('TEST_TOKEN')).called(1);
    expect(RegisterRequestModel(params).toJson()['device_name'], 'kora-app');
  });

  test('logout clears only local token storage', () async {
    await repository.logout();

    verify(() => storage.clear()).called(1);
    verifyNoMoreInteractions(remote);
  });
}
