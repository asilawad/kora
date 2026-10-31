import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/status_pill.dart';

final class OpenStatusIndicator extends StatelessWidget {
  const OpenStatusIndicator({required this.isOpen, super.key});

  final bool isOpen;

  @override
  Widget build(BuildContext context) => StatusPill(
    label: isOpen
        ? AppLocalizations.of(context)!.homeOpenNow
        : AppLocalizations.of(context)!.homeClosedNow,
    variant: isOpen
        ? StatusPillVariant.success
        : StatusPillVariant.neutral,
    icon: isOpen ? Icons.check_circle_outline : Icons.schedule_outlined,
  );
}
