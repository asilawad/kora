import 'package:flutter/material.dart';

import '../../../../core/widgets/chip_pill.dart';

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
  Widget build(BuildContext context) => ChipPill(
    label: label,
    selected: selected,
    onSelected: () => onSelected(id),
  );
}
