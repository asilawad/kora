import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../services/presentation/pages/services_page_arguments.dart';
import '../../domain/entities/category_entity.dart';
import 'home_dimensions.dart';

final class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    required this.categories,
    required this.currencySymbol,
    super.key,
  });

  final List<CategoryEntity> categories;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(HomeDimensions.homeSearchRadius),
    child: InkWell(
      borderRadius: BorderRadius.circular(HomeDimensions.homeSearchRadius),
      onTap: () => context.pushNamed(
        AppRoutes.servicesName,
        extra: ServicesPageArguments(
          categories: categories,
          autofocusSearch: true,
          currencySymbol: currencySymbol,
        ),
      ),
      child: Container(
        height: HomeDimensions.homeSearchHeight,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: HomeDimensions.itemSpacing,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(HomeDimensions.homeSearchRadius),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textSecondary),
            const SizedBox(width: HomeDimensions.smallSpacing),
            Text(
              AppLocalizations.of(context)!.homeSearchHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
