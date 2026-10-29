import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/storage/token_storage.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';
import 'package:kora/features/auth/domain/repositories/auth_repository.dart';
import 'package:kora/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:kora/features/auth/domain/usecases/login_use_case.dart';
import 'package:kora/features/auth/domain/usecases/logout_use_case.dart';
import 'package:kora/features/auth/domain/usecases/register_use_case.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/auth/presentation/widgets/login_form.dart';
import 'package:kora/features/auth/presentation/widgets/register_form.dart';
import 'package:mocktail/mocktail.dart';

class _RepositoryMock extends Mock implements AuthRepository {}

class _TokenStorageMock extends Mock implements TokenStorage {}

void main() {
  late _RepositoryMock repository;
  late _TokenStorageMock tokenStorage;
  late AuthCubit cubit;

  setUp(() {
    repository = _RepositoryMock();
    tokenStorage = _TokenStorageMock();
    cubit = AuthCubit(
      login: LoginUseCase(repository),
      register: RegisterUseCase(repository),
      logout: LogoutUseCase(repository),
      getCurrentUser: GetCurrentUserUseCase(repository),
      tokenStorage: tokenStorage,
    );
  });

  tearDown(() async => cubit.close());

  Future<void> pumpForm(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: BlocProvider.value(value: cubit, child: const LoginForm()),
      ),
    ),
  );

  testWidgets('validates required login fields', (tester) async {
    await pumpForm(tester);
    final context = tester.element(find.byType(LoginForm));

    await tester.tap(find.text(AppLocalizations.of(context)!.authLogin));
    await tester.pump();

    expect(find.text(AppLocalizations.of(context)!.authRequired), findsNWidgets(2));
  });

  testWidgets('shows server field errors inline below the fields', (
    tester,
  ) async {
    const params = LoginParams(
      email: 'student@example.com',
      password: 'Secret123',
    );
    when(
      () => repository.login(params),
    ).thenAnswer(
      (_) async => const Failed(
        ValidationFailure(details: {'email': ['Email is invalid']}),
      ),
    );
    await pumpForm(tester);
    await tester.enterText(find.byType(TextFormField).at(0), params.email);
    await tester.enterText(find.byType(TextFormField).at(1), params.password);
    await tester.tap(find.text('تسجيل الدخول'));
    await tester.pumpAndSettle();

    expect(find.text('Email is invalid'), findsOneWidget);
  });

  testWidgets('validates required fields in registration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const RegisterForm(),
          ),
        ),
      ),
    );
    final context = tester.element(find.byType(RegisterForm));

    await tester.tap(find.text(AppLocalizations.of(context)!.authRegister));
    await tester.pump();

    expect(
      find.text(AppLocalizations.of(context)!.authPhoneRequired),
      findsOneWidget,
    );
    expect(find.text(AppLocalizations.of(context)!.authRequired), findsNWidgets(4));
  });
}
