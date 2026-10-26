import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../../services/presentation/pages/services_page_arguments.dart';
import '../../domain/entities/category_entity.dart';
import 'category_card.dart';
import 'home_dimensions.dart';
import 'section_header.dart';

final class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    required this.categories,
    required this.currencySymbol,
    super.key,
  });

  final List<CategoryEntity> categories;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: AppLocalizations.of(context)!.homeCategories),
        const SizedBox(height: HomeDimensions.smallSpacing),
        SizedBox(
          height: HomeDimensions.categoryCardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: HomeDimensions.itemSpacing),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(
                category: category,
                onTap: () => context.pushNamed(
                  AppRoutes.servicesName,
                  extra: ServicesPageArguments(
                    categories: categories,
                    initialCategoryId: category.id,
                    currencySymbol: currencySymbol,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
