import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/my_bookings/data/models/bookings_page_model.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/my_bookings/domain/entities/booking_scope.dart';
import 'package:kora/features/my_bookings/domain/repositories/my_bookings_repository.dart';
import 'package:kora/features/my_bookings/domain/usecases/cancel_booking_use_case.dart';
import 'package:kora/features/my_bookings/domain/usecases/get_bookings_use_case.dart';
import 'package:kora/features/my_bookings/presentation/cubit/bookings_tab_state.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_cubit.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements MyBookingsRepository {}

BookingsPageModel _page(String path) {
  final json = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return BookingsPageModel.fromResponse(data: json['data'], meta: json['meta']);
}

void main() {
  late _MockRepository repository;
  late MyBookingsCubit cubit;
  final upcoming = _page('test/fixtures/bookings_list_upcoming.json');
  final past = _page('test/fixtures/bookings_list_past.json');

  setUp(() {
    repository = _MockRepository();
    cubit = MyBookingsCubit(
      getBookings: GetBookingsUseCase(repository),
      cancelBooking: CancelBookingUseCase(repository),
    );
  });

  tearDown(() async => cubit.close());

  blocTest<MyBookingsCubit, MyBookingsState>(
    'loads upcoming bookings',
    build: () {
      when(
        () => repository.getBookings(BookingScope.upcoming, page: 1),
      ).thenAnswer((_) async => Success(upcoming));
      return cubit;
    },
    act: (cubit) => cubit.load(BookingScope.upcoming),
    expect: () => [
      const MyBookingsState(
        upcoming: BookingsTabState(status: BookingsLoadStatus.loading),
      ),
      MyBookingsState(
        upcoming: BookingsTabState(
          status: BookingsLoadStatus.loaded,
          items: upcoming.items,
          lastPage: 1,
          total: 1,
        ),
      ),
    ],
  );

  blocTest<MyBookingsCubit, MyBookingsState>(
    'loads past bookings only when its tab is first opened',
    build: () {
      when(
        () => repository.getBookings(BookingScope.upcoming, page: 1),
      ).thenAnswer((_) async => Success(upcoming));
      when(
        () => repository.getBookings(BookingScope.past, page: 1),
      ).thenAnswer((_) async => Success(past));
      return cubit;
    },
    act: (cubit) async {
      await cubit.ensureLoaded(BookingScope.upcoming);
      verifyNever(() => repository.getBookings(BookingScope.past, page: 1));
      await cubit.ensureLoaded(BookingScope.past);
    },
    verify: (_) {
      verify(() => repository.getBookings(BookingScope.upcoming, page: 1))
          .called(1);
      verify(() => repository.getBookings(BookingScope.past, page: 1)).called(1);
    },
    expect: () => [
      const MyBookingsState(
        upcoming: BookingsTabState(status: BookingsLoadStatus.loading),
      ),
      MyBookingsState(
        upcoming: BookingsTabState(
          status: BookingsLoadStatus.loaded,
          items: upcoming.items,
          total: 1,
        ),
      ),
      MyBookingsState(
        upcoming: BookingsTabState(
          status: BookingsLoadStatus.loaded,
          items: upcoming.items,
          total: 1,
        ),
        past: const BookingsTabState(status: BookingsLoadStatus.loading),
      ),
      MyBookingsState(
        upcoming: BookingsTabState(
          status: BookingsLoadStatus.loaded,
          items: upcoming.items,
          total: 1,
        ),
        past: BookingsTabState(
          status: BookingsLoadStatus.loaded,
          items: past.items,
          total: 1,
        ),
      ),
    ],
  );
}
