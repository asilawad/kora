import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/home/presentation/widgets/open_status_indicator.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows open status text', (tester) async {
    await pumpApp(tester, const OpenStatusIndicator(isOpen: true));
    final context = tester.element(find.byType(OpenStatusIndicator));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text(l10n.homeOpenNow), findsOneWidget);
  });

  testWidgets('shows closed status text', (tester) async {
    await pumpApp(tester, const OpenStatusIndicator(isOpen: false));
    final context = tester.element(find.byType(OpenStatusIndicator));
    final l10n = AppLocalizations.of(context)!;

    expect(find.text(l10n.homeClosedNow), findsOneWidget);
  });
}
