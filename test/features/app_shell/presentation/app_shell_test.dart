import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/app_shell/presentation/app_shell.dart';
import 'package:kora/features/app_shell/presentation/app_shell_navigation.dart';
import 'package:kora/features/app_shell/presentation/floating_navigation_bar.dart';

void main() {
  testWidgets('switches tabs and reselecting a tab returns to its root', (
    tester,
  ) async {
    final router = _router();
    addTearDown(router.dispose);
    await tester.pumpWidget(_TestApp(router: router));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingNavigationBar), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('حجوزاتي'), findsOneWidget);
    expect(find.text('home root'), findsOneWidget);
    final requestsBeforeReselect =
        AppShellNavigation.homeScrollRequests.value;
    await tester.tap(find.text('الرئيسية'));
    await tester.pumpAndSettle();
    expect(
      AppShellNavigation.homeScrollRequests.value,
      requestsBeforeReselect + 1,
    );
    await tester.tap(find.text('حجوزاتي'));
    await tester.pumpAndSettle();
    expect(find.text('bookings root'), findsOneWidget);

    router.go('/bookings/past');
    await tester.pumpAndSettle();
    expect(find.text('bookings past'), findsOneWidget);
    await tester.tap(find.text('حجوزاتي'));
    await tester.pumpAndSettle();
    expect(find.text('bookings root'), findsOneWidget);
  });
}

GoRouter _router() => GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const Text('home root'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookings',
              builder: (context, state) => const Text('bookings root'),
              routes: [
                GoRoute(
                  path: 'past',
                  builder: (context, state) => const Text('bookings past'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final class _TestApp extends StatelessWidget {
  const _TestApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    locale: const Locale('ar'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    routerConfig: router,
  );
}
