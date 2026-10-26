import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'home_dimensions.dart';

final class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.id,
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final int? id;
  final String label;
  final bool selected;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) => ChoiceChip(
    label: Text(label),
    selected: selected,
    onSelected: (_) => onSelected(id),
    selectedColor: AppColors.primary,
    backgroundColor: AppColors.surface,
    side: BorderSide(
      color: selected ? AppColors.primary : AppColors.border,
      width: HomeDimensions.categoryBorderWidth,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(HomeDimensions.categoryRadius),
    ),
    labelStyle: TextStyle(
      color: selected ? AppColors.onPrimary : AppColors.textPrimary,
    ),
  );
}
