import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'services_dimensions.dart';

final class ServicesResultsCount extends StatelessWidget {
  const ServicesResultsCount({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(
      start: ServicesDimensions.resultCountSpacing,
    ),
    child: Text(
      AppLocalizations.of(context)!.resultsCount(count),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
      ),
    ),
  );
}
