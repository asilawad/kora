import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import 'app_icon_circle.dart';
import 'widget_dimensions.dart';

final class AppEmptyView extends StatelessWidget {
  const AppEmptyView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(WidgetDimensions.spacingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppIconCircle(icon: Icons.inbox_outlined),
          const SizedBox(height: WidgetDimensions.spacingMedium),
          Text(
            message ?? AppLocalizations.of(context)!.emptyDefaultMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}
