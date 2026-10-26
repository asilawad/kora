import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'services_dimensions.dart';

final class ServicesLoadMoreFailure extends StatelessWidget {
  const ServicesLoadMoreFailure({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ServicesDimensions.footerHeight,
    child: Center(
      child: TextButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh, color: AppColors.primary),
        label: Text(AppLocalizations.of(context)!.loadMoreFailed),
      ),
    ),
  );
}
