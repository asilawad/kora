import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/domain/entities/booking_entity.dart';
import 'package:kora/features/my_bookings/data/models/bookings_page_model.dart';
import 'package:kora/features/my_bookings/domain/entities/booking_scope.dart';
import 'package:kora/features/my_bookings/domain/repositories/my_bookings_repository.dart';
import 'package:kora/features/my_bookings/domain/usecases/cancel_booking_use_case.dart';
import 'package:kora/features/my_bookings/domain/usecases/get_bookings_use_case.dart';
import 'package:kora/features/my_bookings/presentation/cubit/bookings_tab_state.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_cubit.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements MyBookingsRepository {}

Map<String, dynamic> _fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

BookingsPageModel _upcoming() {
  final json = _fixture('test/fixtures/bookings_list_upcoming.json');
  return BookingsPageModel.fromResponse(data: json['data'], meta: json['meta']);
}

BookingModel _cancelled() {
  final json = _fixture('test/fixtures/booking_cancel_response.json');
  return BookingModel.fromJson(
    json['data'] as Map<String, dynamic>,
    serverMessage: json[ApiResponseKeys.message] as String,
  );
}

void main() {
  late _MockRepository repository;
  late MyBookingsCubit cubit;
  late Completer<Result<BookingEntity>> pending;
  final upcoming = _upcoming();

  setUp(() {
    repository = _MockRepository();
    cubit = MyBookingsCubit(
      getBookings: GetBookingsUseCase(repository),
      cancelBooking: CancelBookingUseCase(repository),
    );
  });

  tearDown(() async => cubit.close());

  blocTest<MyBookingsCubit, MyBookingsState>(
    'removes success from upcoming, marks past stale, and emits server message',
    build: () {
      when(
        () => repository.cancelBooking(2791),
      ).thenAnswer((_) async => Success(_cancelled()));
      return cubit;
    },
    seed: () => MyBookingsState(
      upcoming: BookingsTabState(
        status: BookingsLoadStatus.loaded,
        items: upcoming.items,
      ),
    ),
    act: (cubit) => cubit.cancelBooking(2791),
    expect: () => [
      isA<MyBookingsState>().having(
        (state) => state.cancellingIds,
        'cancelling id',
        {2791},
      ),
      isA<MyBookingsState>().having(
        (state) => state.upcoming.items,
        'upcoming removed',
        isEmpty,
      ).having((state) => state.past.stale, 'past stale', isTrue),
      isA<MyBookingsState>().having(
        (state) => state.message,
        'server message',
        'تم إلغاء الحجز',
      ),
    ],
  );

  blocTest<MyBookingsCubit, MyBookingsState>(
    'preserves failure message and refreshes upcoming silently',
    build: () {
      final body = _fixture('test/fixtures/booking_not_cancellable_response.json');
      when(() => repository.cancelBooking(2791)).thenAnswer(
        (_) async => Failed(
          ValidationFailure(
            message: body[ApiResponseKeys.message] as String,
            code: ApiErrorCodes.bookingNotCancellable,
          ),
        ),
      );
      when(
        () => repository.getBookings(BookingScope.upcoming, page: 1),
      ).thenAnswer((_) async => Success(upcoming));
      return cubit;
    },
    seed: () => MyBookingsState(
      upcoming: BookingsTabState(
        status: BookingsLoadStatus.loaded,
        items: upcoming.items,
      ),
    ),
    act: (cubit) => cubit.cancelBooking(2791),
    verify: (_) => verify(
      () => repository.getBookings(BookingScope.upcoming, page: 1),
    ).called(1),
    expect: () => [
      isA<MyBookingsState>().having(
        (state) => state.cancellingIds,
        'cancelling id',
        {2791},
      ),
      isA<MyBookingsState>().having(
        (state) => state.message,
        'server message',
        'لا يمكن إلغاء هذا الحجز الآن',
      ).having((state) => state.messageIsError, 'is error', isTrue),
      isA<MyBookingsState>().having(
        (state) => state.upcoming.total,
        'refreshed total',
        1,
      ).having(
        (state) => state.message,
        'failure message remains',
        'لا يمكن إلغاء هذا الحجز الآن',
      ),
    ],
  );

  blocTest<MyBookingsCubit, MyBookingsState>(
    'ignores duplicate cancellation requests for the same booking',
    build: () {
      pending = Completer<Result<BookingEntity>>();
      when(
        () => repository.cancelBooking(2791),
      ).thenAnswer((_) => pending.future);
      return cubit;
    },
    act: (cubit) async {
      final first = cubit.cancelBooking(2791);
      await Future<void>.delayed(Duration.zero);
      await cubit.cancelBooking(2791);
      pending.complete(Success(_cancelled()));
      await first;
    },
    verify: (_) => verify(() => repository.cancelBooking(2791)).called(1),
    expect: () => [
      isA<MyBookingsState>().having(
        (state) => state.cancellingIds,
        'cancelling id',
        {2791},
      ),
      isA<MyBookingsState>().having(
        (state) => state.past.stale,
        'past stale',
        isTrue,
      ),
      isA<MyBookingsState>().having(
        (state) => state.message,
        'success message',
        'تم إلغاء الحجز',
      ),
    ],
  );

  blocTest<MyBookingsCubit, MyBookingsState>(
    'clears loaded booking data after logout',
    build: () => cubit,
    seed: () => MyBookingsState(
      upcoming: BookingsTabState(
        status: BookingsLoadStatus.loaded,
        items: upcoming.items,
      ),
    ),
    act: (cubit) => cubit.setSignedOut(),
    expect: () => [const MyBookingsState(signedOut: true)],
  );
}
