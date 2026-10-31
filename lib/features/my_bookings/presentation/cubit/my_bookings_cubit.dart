import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../domain/entities/booking_scope.dart';
import '../../domain/entities/bookings_page_entity.dart';
import '../../domain/usecases/cancel_booking_use_case.dart';
import '../../domain/usecases/get_bookings_use_case.dart';
import 'booking_list_helpers.dart';
import 'bookings_tab_state.dart';
import 'my_bookings_state.dart';

final class MyBookingsCubit extends Cubit<MyBookingsState> {
  MyBookingsCubit({
    required GetBookingsUseCase getBookings,
    required CancelBookingUseCase cancelBooking,
  }) : _getBookings = getBookings,
       _cancelBooking = cancelBooking,
       super(const MyBookingsState());

  final GetBookingsUseCase _getBookings;
  final CancelBookingUseCase _cancelBooking;
  final Map<BookingScope, int> _requestIds = {
    BookingScope.upcoming: 0,
    BookingScope.past: 0,
  };

  BookingsTabState tab(BookingScope scope) =>
      scope == BookingScope.upcoming ? state.upcoming : state.past;
  Future<void> ensureLoaded(BookingScope scope) async {
    final tabState = tab(scope);
    if (tabState.status == BookingsLoadStatus.initial || tabState.stale) {
      await load(scope);
    }
  }

  Future<void> load(BookingScope scope) => _fetch(scope);

  Future<void> refresh(BookingScope scope) => _fetch(scope);

  Future<void> loadMore(BookingScope scope) async {
    final current = tab(scope);
    if (current.status == BookingsLoadStatus.loading ||
        current.status == BookingsLoadStatus.loadingMore ||
        current.status == BookingsLoadStatus.failure ||
        current.items.isEmpty ||
        !current.hasMore) {
      return;
    }
    final page = current.page + 1;
    final requestId = _nextRequestId(scope);
    _emitTab(
      scope,
      current.copyWith(status: BookingsLoadStatus.loadingMore, clearFailure: true),
    );
    final result = await _getBookings(scope, page: page);
    if (isClosed || requestId != _requestIds[scope]) return;
    switch (result) {
      case Success<BookingsPageEntity>(:final data):
        _emitTab(
          scope,
          tab(scope).copyWith(
            status: BookingsLoadStatus.loaded,
            items: appendUniqueBookings(tab(scope).items, data.items),
            page: data.page,
            lastPage: data.lastPage,
            total: data.total,
            stale: false,
            clearFailure: true,
          ),
        );
      case Failed<BookingsPageEntity>(:final failure):
        _emitTab(
          scope,
          tab(scope).copyWith(
            status: BookingsLoadStatus.loadMoreFailure,
            failure: failure,
          ),
        );
    }
  }

  Future<void> cancelBooking(int id, {String? reason}) async {
    if (state.cancellingIds.contains(id)) return;
    emit(
      state.copyWith(
        cancellingIds: {...state.cancellingIds, id},
        clearMessage: true,
      ),
    );
    final result = await _cancelBooking(id, reason: reason);
    if (isClosed) return;
    final cancelling = {...state.cancellingIds}..remove(id);
    switch (result) {
      case Success<BookingEntity>(:final data):
        final upcoming = state.upcoming.copyWith(
          items: state.upcoming.items.where((item) => item.id != id).toList(),
        );
        final past = state.past;
        final nextPast = past.status == BookingsLoadStatus.initial || past.stale
            ? past.copyWith(stale: true)
            : past.copyWith(
                items: prependUniqueBooking(past.items, data),
                total: past.total + 1,
              );
        emit(
          state.copyWith(
            upcoming: upcoming,
            past: nextPast,
            cancellingIds: cancelling,
          ),
        );
        _emitMessage(data.serverMessage ?? data.statusLabel, isError: false);
      case Failed<BookingEntity>(:final failure):
        _emitMessage(
          failure.message ?? failure.code ?? '',
          isError: true,
          cancellingIds: cancelling,
        );
        await _fetch(BookingScope.upcoming, silent: true);
    }
  }

  Future<void> refreshLoaded() async {
    if (state.signedOut) return;
    await _fetch(
      BookingScope.upcoming,
      silent: tab(BookingScope.upcoming).items.isNotEmpty,
    );
    if (state.past.status != BookingsLoadStatus.initial) {
      await _fetch(BookingScope.past, silent: true);
    }
  }

  void clearMessage() => emit(state.copyWith(clearMessage: true));
  void setSignedOut() {
    _nextRequestId(BookingScope.upcoming);
    _nextRequestId(BookingScope.past);
    emit(const MyBookingsState(signedOut: true));
  }
  void setSignedIn() {
    if (state.signedOut) emit(const MyBookingsState());
  }
  Future<void> _fetch(BookingScope scope, {bool silent = false}) async {
    final previous = tab(scope);
    final requestId = _nextRequestId(scope);
    if (!silent) {
      _emitTab(
        scope,
        previous.copyWith(status: BookingsLoadStatus.loading, clearFailure: true),
      );
    }
    final result = await _getBookings(scope);
    if (isClosed || requestId != _requestIds[scope]) return;
    switch (result) {
      case Success<BookingsPageEntity>(:final data):
        _emitTab(
          scope,
          tab(scope).copyWith(
            status: BookingsLoadStatus.loaded,
            items: data.items,
            page: data.page,
            lastPage: data.lastPage,
            total: data.total,
            stale: false,
            clearFailure: true,
          ),
        );
      case Failed<BookingsPageEntity>(:final failure):
        if (!silent || previous.items.isEmpty) {
          _emitTab(
            scope,
            tab(scope).copyWith(
              status: BookingsLoadStatus.failure,
              failure: failure,
            ),
          );
        }
    }
  }

  void _emitMessage(
    String message, {
    required bool isError,
    Set<int>? cancellingIds,
  }) => emit(
    state.copyWith(
      cancellingIds: cancellingIds,
      message: message,
      messageIsError: isError,
      messageId: state.messageId + 1,
    ),
  );

  void _emitTab(BookingScope scope, BookingsTabState tabState) {
    emit(
      state.copyWith(
        upcoming: scope == BookingScope.upcoming ? tabState : null,
        past: scope == BookingScope.past ? tabState : null,
      ),
    );
  }

  int _nextRequestId(BookingScope scope) {
    final next = (_requestIds[scope] ?? 0) + 1;
    _requestIds[scope] = next;
    return next;
  }
}
