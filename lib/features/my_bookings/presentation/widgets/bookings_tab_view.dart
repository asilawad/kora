import 'package:flutter/material.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/booking_scope.dart';
import '../cubit/bookings_tab_state.dart';
import '../cubit/my_bookings_cubit.dart';
import '../my_bookings_dimensions.dart';
import 'booking_card.dart';

final class BookingsTabView extends StatefulWidget {
  const BookingsTabView({
    required this.scope,
    required this.state,
    required this.cubit,
    required this.cancellingIds,
    super.key,
  });

  final BookingScope scope;
  final BookingsTabState state;
  final MyBookingsCubit cubit;
  final Set<int> cancellingIds;

  @override
  State<BookingsTabView> createState() => _BookingsTabViewState();
}

final class _BookingsTabViewState extends State<BookingsTabView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreIfNeeded);
  }

  @override
  void didUpdateWidget(BookingsTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadMoreIfNeeded();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreIfNeeded)
      ..dispose();
    super.dispose();
  }

  void _loadMoreIfNeeded() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter >
            MyBookingsDimensions.loadMoreExtent) {
      return;
    }
    widget.cubit.loadMore(widget.scope);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;
    final state = widget.state;
    if (state.status == BookingsLoadStatus.initial ||
        (state.status == BookingsLoadStatus.loading && state.items.isEmpty)) {
      return const AppLoader();
    }
    if (state.status == BookingsLoadStatus.failure && state.items.isEmpty) {
      return AppErrorView(
        message: state.failure?.localized(l10n) ?? l10n.errorUnknown,
        onRetry: () => widget.cubit.refresh(widget.scope),
      );
    }
    if (state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => widget.cubit.refresh(widget.scope),
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(
              height: MyBookingsDimensions.loadMoreExtent,
              child: AppEmptyView(),
            ),
          ],
        ),
      );
    }
    final showLoadMore = state.status == BookingsLoadStatus.loadingMore ||
        state.status == BookingsLoadStatus.loadMoreFailure;
    return RefreshIndicator(
      onRefresh: () => widget.cubit.refresh(widget.scope),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(
          MyBookingsDimensions.pagePadding,
          MyBookingsDimensions.pagePadding,
          MyBookingsDimensions.pagePadding,
          MyBookingsDimensions.bottomListPadding,
        ),
        itemCount: state.items.length + (showLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.items.length) {
            return _LoadMoreRow(
              state: state,
              onRetry: () => widget.cubit.loadMore(widget.scope),
            );
          }
          final booking = state.items[index];
          return BookingCard(
            booking: booking,
            isCancelling: widget.cancellingIds.contains(booking.id),
            onCancel: (reason) =>
                widget.cubit.cancelBooking(booking.id, reason: reason),
          );
        },
      ),
    );
  }
}

final class _LoadMoreRow extends StatelessWidget {
  const _LoadMoreRow({required this.state, required this.onRetry});

  final BookingsTabState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) =>
      state.status == BookingsLoadStatus.loadMoreFailure
      ? TextButton(
          onPressed: onRetry,
          child: Text(AppLocalizations.of(context)!.myBookingsLoadMore),
        )
      : const Padding(
          padding: EdgeInsets.all(MyBookingsDimensions.pagePadding),
          child: AppLoader(),
        );
}
