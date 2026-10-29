import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/domain/entities/auth_session.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/user_entity.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/auth/presentation/require_auth.dart';
import 'package:mocktail/mocktail.dart';

class _RepositoryMock extends Mock implements AuthRepository {}

class _TokenStorageMock extends Mock implements TokenStorage {}

void main() {
  testWidgets('returns true without showing a sheet when already signed in', (
    tester,
  ) async {
    final repository = _RepositoryMock();
    final session = AuthSession(
      token: 'token',
      user: const UserEntity(
        id: 1,
        name: 'Student',
        email: 'student@example.com',
        phone: '0599000000',
        role: 'customer',
        roleLabel: 'Customer',
        initials: 'S',
        isActive: true,
        lastLoginAt: '',
        createdAt: '',
      ),
    );
    const params = LoginParams(email: 'student@example.com', password: 'Secret123');
    when(
      () => repository.login(params),
    ).thenAnswer((_) async => Success(session));
    final cubit = AuthCubit(
      login: LoginUseCase(repository),
      register: RegisterUseCase(repository),
      logout: LogoutUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      tokenStorage: _TokenStorageMock(),
    );
    await cubit.login(params);
    final sl = GetIt.instance;
    await sl.reset();
    sl.registerSingleton<AuthCubit>(cubit);
    var result = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async => result = await requireAuth(context),
              child: const Text('continue'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('continue'));
    await tester.pumpAndSettle();

    expect(result, isTrue);
    expect(find.text(AppLocalizations.of(
      tester.element(find.byType(Scaffold)),
    )!.authSheetTitle), findsNothing);
    await sl.reset();
    await cubit.close();
  });
}
