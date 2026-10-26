import 'package:flutter/material.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/service_entity.dart';
import '../cubit/home_state.dart';
import 'home_loaded_view.dart';

final class HomeStateView extends StatelessWidget {
  const HomeStateView({
    required this.state,
    required this.onLoad,
    required this.onRefresh,
    required this.onCategorySelected,
    required this.onBook,
    required this.onServiceTap,
    super.key,
  });

  final HomeState state;
  final VoidCallback onLoad;
  final Future<void> Function() onRefresh;
  final ValueChanged<int?> onCategorySelected;
  final ValueChanged<ServiceEntity> onBook;
  final ValueChanged<ServiceEntity> onServiceTap;

  @override
  Widget build(BuildContext context) => switch (state) {
    HomeInitial() || HomeLoading() => const Center(child: AppLoader()),
    HomeFailure(:final failure) => AppErrorView(
      message: failure.localized(AppLocalizations.of(context)!),
      onRetry: onLoad,
    ),
    HomeLoaded(:final data, :final selectedCategoryId) => HomeLoadedView(
      state: HomeLoaded(data, selectedCategoryId: selectedCategoryId),
      onRefresh: onRefresh,
      onCategorySelected: onCategorySelected,
      onBook: onBook,
      onServiceTap: onServiceTap,
    ),
  };
}
