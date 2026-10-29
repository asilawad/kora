import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../home/domain/entities/category_entity.dart';
import '../cubit/services_cubit.dart';
import '../cubit/services_state.dart';
import '../widgets/services_category_chips.dart';
import '../widgets/services_dimensions.dart';
import '../widgets/services_results_count.dart';
import '../widgets/services_results_sliver.dart';
import '../widgets/services_search_field.dart';
import '../widgets/services_sort_button.dart';

final class ServicesPageView extends StatelessWidget {
  const ServicesPageView({
    required this.categories,
    required this.autofocusSearch,
    required this.currencySymbol,
    super.key,
  });

  final List<CategoryEntity> categories;
  final bool autofocusSearch;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) => NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter <=
                ServicesDimensions.loadMoreThreshold) {
              context.read<ServicesCubit>().loadMore();
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: context.read<ServicesCubit>().refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    ServicesDimensions.pagePadding,
                    ServicesDimensions.itemSpacing,
                    ServicesDimensions.pagePadding,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.servicesTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.all(
                    ServicesDimensions.pagePadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ServicesSearchField(
                      autofocus: autofocusSearch,
                      onChanged: context.read<ServicesCubit>().onSearchChanged,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.only(
                    start: ServicesDimensions.pagePadding,
                    end: ServicesDimensions.pagePadding,
                    bottom: ServicesDimensions.sectionSpacing,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ServicesCategoryChips(
                      categories: categories,
                      selectedCategoryId: state.query.categoryId,
                      onSelected: context.read<ServicesCubit>().selectCategory,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: ServicesDimensions.pagePadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ServicesResultsCount(count: state.total),
                        ServicesSortButton(
                          selectedSort: state.query.sort,
                          onSelected: context.read<ServicesCubit>().selectSort,
                        ),
                      ],
                    ),
                  ),
                ),
                ServicesResultsSliver(
                  state: state,
                  currencySymbol: currencySymbol,
                  onRetry: context.read<ServicesCubit>().retry,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
