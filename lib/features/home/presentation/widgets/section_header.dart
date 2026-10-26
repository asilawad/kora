import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'home_dimensions.dart';

final class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.onSeeAll,
    super.key,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
      if (onSeeAll != null)
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            AppLocalizations.of(context)!.homeSeeAll,
            style: const TextStyle(color: AppColors.accent),
          ),
        ),
      if (onSeeAll != null)
        const SizedBox(width: HomeDimensions.smallSpacing),
    ],
  );
}
