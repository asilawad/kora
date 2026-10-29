import 'package:equatable/equatable.dart';

import 'bookings_tab_state.dart';

final class MyBookingsState extends Equatable {
  const MyBookingsState({
    this.upcoming = const BookingsTabState(),
    this.past = const BookingsTabState(),
    this.cancellingIds = const {},
    this.message,
    this.messageIsError = false,
    this.messageId = 0,
    this.signedOut = false,
  });

  final BookingsTabState upcoming;
  final BookingsTabState past;
  final Set<int> cancellingIds;
  final String? message;
  final bool messageIsError;
  final int messageId;
  final bool signedOut;

  MyBookingsState copyWith({
    BookingsTabState? upcoming,
    BookingsTabState? past,
    Set<int>? cancellingIds,
    String? message,
    bool clearMessage = false,
    bool? messageIsError,
    int? messageId,
    bool? signedOut,
  }) => MyBookingsState(
    upcoming: upcoming ?? this.upcoming,
    past: past ?? this.past,
    cancellingIds: cancellingIds ?? this.cancellingIds,
    message: clearMessage ? null : message ?? this.message,
    messageIsError: messageIsError ?? this.messageIsError,
    messageId: messageId ?? this.messageId,
    signedOut: signedOut ?? this.signedOut,
  );

  @override
  List<Object?> get props => [
    upcoming,
    past,
    cancellingIds,
    message,
    messageIsError,
    messageId,
    signedOut,
  ];
}
