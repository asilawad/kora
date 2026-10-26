import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/service_sort.dart';
import 'services_dimensions.dart';
import 'services_sort_sheet.dart';

final class ServicesSortButton extends StatelessWidget {
  const ServicesSortButton({
    required this.selectedSort,
    required this.onSelected,
    super.key,
  });

  final ServiceSort selectedSort;
  final ValueChanged<ServiceSort> onSelected;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: () => showModalBottomSheet<void>(
      context: context,
      builder: (context) => ServicesSortSheet(
        selectedSort: selectedSort,
        onSelected: onSelected,
      ),
    ),
    icon: const Icon(
      Icons.sort,
      size: ServicesDimensions.sortIconSize,
      color: AppColors.primary,
    ),
    label: Text(AppLocalizations.of(context)!.sortLabel),
  );
}
