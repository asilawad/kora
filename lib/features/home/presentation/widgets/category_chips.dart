import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/entities/category_entity.dart';
import 'category_chip.dart';
import 'home_dimensions.dart';

final class CategoryChips extends StatelessWidget {
  const CategoryChips({
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
    height: HomeDimensions.tapTargetHeight,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length + 1,
      separatorBuilder: (context, index) =>
          const SizedBox(width: HomeDimensions.smallSpacing),
      itemBuilder: (context, index) {
        if (index == 0) {
          return CategoryChip(
            id: null,
            label: AppLocalizations.of(context)!.homeAll,
            selected: selectedCategoryId == null,
            onSelected: onSelected,
          );
        }
        final category = categories[index - 1];
        return CategoryChip(
          id: category.id,
          label: category.name,
          selected: category.id == selectedCategoryId,
          onSelected: onSelected,
        );
      },
    ),
  );
}
