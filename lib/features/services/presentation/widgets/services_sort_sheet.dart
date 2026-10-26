import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/service_sort.dart';
import 'services_dimensions.dart';

final class ServicesSortSheet extends StatelessWidget {
  const ServicesSortSheet({
    required this.selectedSort,
    required this.onSelected,
    super.key,
  });

  final ServiceSort selectedSort;
  final ValueChanged<ServiceSort> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(
          ServicesDimensions.sectionSpacing,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(l10n.sortLabel, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: ServicesDimensions.sortSheetSpacing),
            for (final sort in ServiceSort.values)
              RadioListTile<ServiceSort>(
                value: sort,
                groupValue: selectedSort,
                activeColor: AppColors.primary,
                title: Text(_label(l10n, sort)),
                onChanged: (value) {
                  if (value == null) return;
                  onSelected(value);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _label(AppLocalizations l10n, ServiceSort sort) => switch (sort) {
    ServiceSort.popular => l10n.sortPopular,
    ServiceSort.priceAsc => l10n.sortPriceAsc,
    ServiceSort.priceDesc => l10n.sortPriceDesc,
    ServiceSort.durationAsc => l10n.sortDurationAsc,
    ServiceSort.nameAsc => l10n.sortName,
  };
}
