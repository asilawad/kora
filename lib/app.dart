import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/l10n/generated/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

final class KoraApp extends StatelessWidget {
  const KoraApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
    theme: AppTheme.light,
    locale: const Locale(AppConstants.defaultLocaleCode),
    supportedLocales: AppConstants.supportedLocaleCodes
        .map(Locale.new)
        .toList(growable: false),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    routerConfig: AppRouter.router,
  );
}
