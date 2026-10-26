import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../home/domain/entities/category_entity.dart';
import 'services_dimensions.dart';

final class ServicesCategoryChip extends StatelessWidget {
  const ServicesCategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.category,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final CategoryEntity? category;

  @override
  Widget build(BuildContext context) => ChoiceChip(
    selected: selected,
    onSelected: (_) => onTap(),
    avatar: category == null
        ? null
        : ClipOval(
            child: SizedBox(
              width: ServicesDimensions.categoryImageSize,
              height: ServicesDimensions.categoryImageSize,
              child: category!.image.isEmpty
                  ? const ColoredBox(
                      color: AppColors.grey100,
                      child: Icon(
                        Icons.category_outlined,
                        size: ServicesDimensions.categoryFallbackIconSize,
                      ),
                    )
                  : AppNetworkImage(url: category!.image),
            ),
          ),
    label: Text(label),
    labelStyle: TextStyle(
      color: selected ? AppColors.onPrimary : AppColors.textPrimary,
    ),
    selectedColor: AppColors.primary,
    backgroundColor: AppColors.surface,
    side: const BorderSide(color: AppColors.border),
    visualDensity: VisualDensity.compact,
  );
}
