import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import 'app_icon_circle.dart';
import 'tap_scale.dart';
import 'widget_dimensions.dart';

final class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIconCircle(icon: Icons.error_outline),
          const SizedBox(height: WidgetDimensions.spacingSmall),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: WidgetDimensions.spacingMedium),
          TapScale(
            onTap: onRetry,
            child: Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: WidgetDimensions.tapTarget,
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: WidgetDimensions.spacingLarge,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  boxShadow: AppShadows.card,
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  AppLocalizations.of(context)!.retry,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
