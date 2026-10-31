import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/section_title.dart';

final class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.onSeeAll,
    super.key,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) => SectionTitle(
    title: title,
    trailingText: onSeeAll == null
        ? null
        : AppLocalizations.of(context)!.homeSeeAll,
    onTrailingTap: onSeeAll,
  );
}
