import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../theme/app_colors.dart';

final class AppEmptyView extends StatelessWidget {
  const AppEmptyView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      message ?? AppLocalizations.of(context)!.emptyDefaultMessage,
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppColors.textSecondary),
    ),
  );
}
