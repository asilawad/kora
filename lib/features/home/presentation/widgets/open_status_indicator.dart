import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'home_dimensions.dart';

final class OpenStatusIndicator extends StatelessWidget {
  const OpenStatusIndicator({required this.isOpen, super.key});

  final bool isOpen;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: HomeDimensions.statusDotSize,
        height: HomeDimensions.statusDotSize,
        decoration: BoxDecoration(
          color: isOpen ? AppColors.success : AppColors.grey500,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: HomeDimensions.statusDotGap),
      Text(
        isOpen
            ? AppLocalizations.of(context)!.homeOpenNow
            : AppLocalizations.of(context)!.homeClosedNow,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );
}
