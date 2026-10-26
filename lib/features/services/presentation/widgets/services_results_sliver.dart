import 'package:flutter/material.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../home/presentation/widgets/home_dimensions.dart';
import '../../../home/presentation/widgets/service_card.dart';
import '../cubit/services_state.dart';
import 'services_dimensions.dart';
import 'services_load_more_failure.dart';
import 'services_load_more_indicator.dart';

final class ServicesResultsSliver extends StatelessWidget {
  const ServicesResultsSliver({
    required this.state,
    required this.currencySymbol,
    required this.onRetry,
    super.key,
  });

  final ServicesState state;
  final String currencySymbol;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (state.status == ServicesStatus.failure) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: AppErrorView(
          message: state.failure!.localized(l10n),
          onRetry: onRetry,
        ),
      );
    }
    if (state.items.isEmpty && state.status == ServicesStatus.loading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: AppLoader(),
      );
    }
    if (state.items.isEmpty && state.status == ServicesStatus.loaded) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: AppEmptyView(
          message: state.query.search.trim().isEmpty
              ? l10n.noResults
              : l10n.noResultsForSearch,
        ),
      );
    }
    return SliverMainAxisGroup(
      slivers: [
        if (state.status == ServicesStatus.loading)
          const SliverToBoxAdapter(
            child: LinearProgressIndicator(
              minHeight: HomeDimensions.serviceCardBorderWidth,
              color: AppColors.primary,
            ),
          ),
        SliverPadding(
          padding: const EdgeInsetsDirectional.all(
            ServicesDimensions.pagePadding,
          ),
          sliver: SliverList.separated(
            itemCount: state.items.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: HomeDimensions.itemSpacing),
            itemBuilder: (context, index) => ServiceCard(
              service: state.items[index],
              currencySymbol: currencySymbol,
            ),
          ),
        ),
        if (state.status == ServicesStatus.loadingMore)
          const SliverToBoxAdapter(child: ServicesLoadMoreIndicator()),
        if (state.status == ServicesStatus.loadMoreFailure)
          SliverToBoxAdapter(
            child: ServicesLoadMoreFailure(onRetry: onRetry),
          ),
      ],
    );
  }
}
