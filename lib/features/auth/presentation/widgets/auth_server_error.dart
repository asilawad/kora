import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

final class AuthServerError extends StatelessWidget {
  const AuthServerError({required this.failure, super.key});

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    if (failure == null || failure is ValidationFailure) {
      return const SizedBox.shrink();
    }
    return Semantics(
      liveRegion: true,
      child: Text(
        failure!.localized(AppLocalizations.of(context)!),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.error,
        ),
      ),
    );
  }
}
