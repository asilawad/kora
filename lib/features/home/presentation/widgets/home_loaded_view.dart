import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../services/presentation/pages/services_page_arguments.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../cubit/home_state.dart';
import 'courts_row.dart';
import 'featured_list.dart';
import 'home_dimensions.dart';
import 'home_header.dart';
import 'category_chips.dart';
import 'categories_section.dart';
import 'home_search_bar.dart';
import 'place_cover_card.dart';
import 'services_list.dart';

final class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({
    required this.state,
    required this.onRefresh,
    required this.onCategorySelected,
    required this.onBook,
    required this.onServiceTap,
    this.scrollController,
    super.key,
  });

  final HomeLoaded state;
  final Future<void> Function() onRefresh;
  final ValueChanged<int?> onCategorySelected;
  final ValueChanged<ServiceEntity> onBook;
  final ValueChanged<ServiceEntity> onServiceTap;
  final ScrollController? scrollController;

  HomeDataEntity get data => state.data;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: onRefresh,
    child: CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.all(HomeDimensions.pagePadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              HomeHeader(place: data.place),
              const SizedBox(height: HomeDimensions.itemSpacing),
              HomeSearchBar(
                categories: data.categories,
                currencySymbol: data.place.currencySymbol,
              ),
              const SizedBox(height: HomeDimensions.sectionSpacing),
              PlaceCoverCard(place: data.place),
              if (data.categories.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                CategoriesSection(
                  categories: data.categories,
                  currencySymbol: data.place.currencySymbol,
                ),
              ],
              if (data.featured.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                FeaturedList(
                  services: data.featured,
                  currencySymbol: data.place.currencySymbol,
                  onServiceTap: (service) => context.pushNamed(
                    AppRoutes.serviceDetailsName,
                    pathParameters: {
                      AppRoutes.serviceIdParameter: service.id.toString(),
                    },
                    extra: service,
                  ),
                ),
              ],
              const SizedBox(height: HomeDimensions.sectionSpacing),
              CategoryChips(
                categories: data.categories,
                selectedCategoryId: state.selectedCategoryId,
                onSelected: onCategorySelected,
              ),
              const SizedBox(height: HomeDimensions.sectionSpacing),
              ServicesList(
                services: state.filteredPopular,
                currencySymbol: data.place.currencySymbol,
                onBook: onBook,
                onTap: onServiceTap,
                onSeeAll: () => context.pushNamed(
                  AppRoutes.servicesName,
                  extra: ServicesPageArguments(
                    categories: data.categories,
                    currencySymbol: data.place.currencySymbol,
                  ),
                ),
              ),
              if (data.staff.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                CourtsRow(courts: data.staff),
              ],
            ]),
          ),
        ),
      ],
    ),
  );
}
