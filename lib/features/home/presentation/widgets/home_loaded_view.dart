import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../services/presentation/pages/services_page_arguments.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../cubit/home_state.dart';
import 'courts_row.dart';
import 'featured_list.dart';
import 'home_dimensions.dart';
import 'floating_place_header.dart';
import 'category_chips.dart';
import 'categories_section.dart';
import 'home_search_bar.dart';
import 'home_section_entrance.dart';
import 'offers_carousel.dart';
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
    color: AppColors.primary,
    onRefresh: onRefresh,
    child: CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.all(HomeDimensions.pagePadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              HomeSectionEntrance(
                delay: HomeDimensions.sectionDelay0,
                child: FloatingPlaceHeader(place: data.place),
              ),
              const SizedBox(height: HomeDimensions.sectionSpacing),
              HomeSectionEntrance(
                delay: HomeDimensions.sectionDelay1,
                child: HomeSearchBar(
                  categories: data.categories,
                  currencySymbol: data.place.currencySymbol,
                ),
              ),
              if (data.featured.any(
                    (service) => service.discountPercent != null,
                  ) ||
                  data.popular.any(
                    (service) => service.discountPercent != null,
                  )) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                HomeSectionEntrance(
                  delay: HomeDimensions.sectionDelay2,
                  child: OffersCarousel(
                    featured: data.featured,
                    popular: data.popular,
                    currencySymbol: data.place.currencySymbol,
                    onServiceTap: onServiceTap,
                  ),
                ),
              ],
              if (data.categories.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                HomeSectionEntrance(
                  delay: HomeDimensions.sectionDelay3,
                  child: CategoriesSection(
                    categories: data.categories,
                    currencySymbol: data.place.currencySymbol,
                  ),
                ),
              ],
              if (data.featured.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                HomeSectionEntrance(
                  delay: HomeDimensions.sectionDelay4,
                  child: FeaturedList(
                    services: data.featured,
                    currencySymbol: data.place.currencySymbol,
                    onServiceTap: onServiceTap,
                  ),
                ),
              ],
              const SizedBox(height: HomeDimensions.sectionSpacing),
              HomeSectionEntrance(
                delay: HomeDimensions.sectionDelay5,
                child: CategoryChips(
                  categories: data.categories,
                  selectedCategoryId: state.selectedCategoryId,
                  onSelected: onCategorySelected,
                ),
              ),
              const SizedBox(height: HomeDimensions.sectionSpacing),
              HomeSectionEntrance(
                delay: HomeDimensions.sectionDelay6,
                child: ServicesList(
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
              ),
              if (data.staff.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                HomeSectionEntrance(
                  delay: HomeDimensions.sectionDelay6,
                  child: CourtsRow(courts: data.staff),
                ),
              ],
            ]),
          ),
        ),
      ],
    ),
  );
}
