import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../home/domain/entities/category_entity.dart';
import 'services_category_chip.dart';
import 'services_dimensions.dart';

final class ServicesCategoryChips extends StatelessWidget {
  const ServicesCategoryChips({
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
    super.key,
  });

  final List<CategoryEntity> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: ServicesDimensions.categoryChipHeight,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length + 1,
      separatorBuilder: (context, index) =>
          const SizedBox(width: ServicesDimensions.itemSpacing),
      itemBuilder: (context, index) {
        if (index == 0) {
          return ServicesCategoryChip(
            label: AppLocalizations.of(context)!.homeAll,
            selected: selectedCategoryId == null,
            onTap: () => onSelected(null),
          );
        }
        final category = categories[index - 1];
        return ServicesCategoryChip(
          label: category.name,
          category: category,
          selected: category.id == selectedCategoryId,
          onTap: () => onSelected(category.id),
        );
      },
    ),
  );
}
