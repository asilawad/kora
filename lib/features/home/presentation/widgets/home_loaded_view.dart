import 'package:flutter/material.dart';

import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../cubit/home_state.dart';
import 'courts_row.dart';
import 'featured_list.dart';
import 'home_dimensions.dart';
import 'home_header.dart';
import 'category_chips.dart';
import 'place_cover_card.dart';
import 'services_list.dart';

final class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({
    required this.state,
    required this.onRefresh,
    required this.onCategorySelected,
    required this.onBook,
    required this.onServiceTap,
    super.key,
  });

  final HomeLoaded state;
  final Future<void> Function() onRefresh;
  final ValueChanged<int?> onCategorySelected;
  final ValueChanged<ServiceEntity> onBook;
  final ValueChanged<ServiceEntity> onServiceTap;

  HomeDataEntity get data => state.data;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: onRefresh,
    child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.all(HomeDimensions.pagePadding),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              HomeHeader(place: data.place),
              const SizedBox(height: HomeDimensions.sectionSpacing),
              PlaceCoverCard(place: data.place),
              if (data.featured.isNotEmpty) ...[
                const SizedBox(height: HomeDimensions.sectionSpacing),
                FeaturedList(
                  services: data.featured,
                  currencySymbol: data.place.currencySymbol,
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
