import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/l10n/generated/app_localizations.dart';

final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.logo),
            Text(l10n.appName),
          ],
        ),
      ),
    );
  }
}
