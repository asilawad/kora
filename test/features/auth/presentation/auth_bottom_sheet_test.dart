import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/core/widgets/primary_button.dart';
import 'package:kora/features/auth/domain/entities/auth_session.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/entities/user_entity.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:kora/features/auth/presentation/auth_bottom_sheet.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _RepositoryMock extends Mock implements AuthRepository {}

class _TokenStorageMock extends Mock implements TokenStorage {}

void main() {
  testWidgets('closes with true after successful login', (tester) async {
    final repository = _RepositoryMock();
    const user = UserEntity(
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
    );
    const params = LoginParams(
      email: 'student@example.com',
      password: 'Secret123',
    );
    when(
      () => repository.login(params),
    ).thenAnswer((_) async => const Success(AuthSession(token: 'token', user: user)));
    final cubit = AuthCubit(
      login: LoginUseCase(repository),
      register: RegisterUseCase(repository),
      logout: LogoutUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      tokenStorage: _TokenStorageMock(),
    );
    final sl = GetIt.instance;
    await sl.reset();
    sl.registerSingleton<AuthCubit>(cubit);
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              key: const ValueKey('open-auth'),
              onPressed: () async => result = await AuthBottomSheet.show(context),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('open-auth')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).at(0),
      params.email,
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      params.password,
    );
    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    expect(result, isTrue);
    await tester.pumpWidget(const SizedBox());
    await sl.reset();
    await cubit.close();
  });
}
