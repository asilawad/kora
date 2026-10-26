import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/presentation/widgets/home_search_bar.dart';
import 'package:kora/features/home/domain/entities/category_entity.dart';
import 'package:kora/features/services/presentation/pages/services_page_arguments.dart';

void main() {
  testWidgets('opens services with search autofocus', (tester) async {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => Scaffold(
            body: HomeSearchBar(
              categories: const <CategoryEntity>[],
              currencySymbol: '',
            ),
          ),
        ),
        GoRoute(
          path: '/services',
          name: 'services',
          builder: (context, state) {
            final arguments = state.extra! as ServicesPageArguments;
            return Scaffold(
              body: Text('${arguments.autofocusSearch}'),
            );
          },
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
    await tester.tap(find.byType(HomeSearchBar));
    await tester.pumpAndSettle();

    expect(find.text('true'), findsOneWidget);
  });
}
