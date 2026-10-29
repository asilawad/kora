import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/widgets/app_error_view.dart';
import 'package:kora/features/services/presentation/pages/services_page.dart';
import 'package:kora/features/home/presentation/widgets/home_search_bar.dart';

import 'app_flow_harness.dart';
import 'app_flow_test_helpers.dart';

void main() {
  testWidgets('retries offline Home and Services requests inline', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    final harness = await AppFlowHarness.create();
    await harness.register();
    harness.homeRepository
      ..current = const Failed(NetworkFailure())
      ..next.add(Success(harness.home));
    harness.servicesRepository
      ..current = const Failed(NetworkFailure())
      ..next.add(Success(harness.servicesPage));

    await tester.pumpWidget(const KoraApp());
    await pumpFrames(tester);
    final homeError = find.byType(AppErrorView).first;
    final retryLabel = AppLocalizations.of(tester.element(homeError))!.retry;
    await tester.tap(find.descendant(
      of: homeError,
      matching: find.text(retryLabel),
    ));
    await pumpFrames(tester);
    expect(find.byType(HomeSearchBar), findsOneWidget);

    await tester.ensureVisible(find.byType(HomeSearchBar));
    await tester.tap(find.byType(HomeSearchBar));
    await pumpFrames(tester);
    expect(find.byType(ServicesPage), findsOneWidget);
    expect(harness.servicesRepository.calls, 1);
    expect(find.byType(AppErrorView), findsOneWidget);
    final servicesError = find.byType(AppErrorView);
    final servicesRetry = AppLocalizations.of(
      tester.element(servicesError),
    )!.retry;
    await tester.tap(find.descendant(
      of: servicesError,
      matching: find.text(servicesRetry),
    ));
    await pumpFrames(tester);

    expect(
      find.text(harness.servicesPage.items.first.name),
      findsAtLeastNWidgets(1),
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.binding.setSurfaceSize(null);
  });
}
