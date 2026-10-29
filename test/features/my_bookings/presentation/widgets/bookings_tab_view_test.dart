import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/widgets/app_empty_view.dart';
import 'package:kora/core/widgets/app_error_view.dart';
import 'package:kora/features/my_bookings/domain/entities/booking_scope.dart';
import 'package:kora/features/my_bookings/domain/repositories/my_bookings_repository.dart';
import 'package:kora/features/my_bookings/domain/usecases/cancel_booking_use_case.dart';
import 'package:kora/features/my_bookings/domain/usecases/get_bookings_use_case.dart';
import 'package:kora/features/my_bookings/presentation/cubit/bookings_tab_state.dart';
import 'package:kora/features/my_bookings/presentation/cubit/my_bookings_cubit.dart';
import 'package:kora/features/my_bookings/presentation/widgets/bookings_tab_view.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements MyBookingsRepository {}

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  late _MockRepository repository;
  late MyBookingsCubit cubit;

  setUp(() {
    repository = _MockRepository();
    cubit = MyBookingsCubit(
      getBookings: GetBookingsUseCase(repository),
      cancelBooking: CancelBookingUseCase(repository),
    );
  });

  tearDown(() async => cubit.close());

  testWidgets('shows an empty state for a loaded empty tab', (tester) async {
    await tester.pumpWidget(
      _app(
        BookingsTabView(
          scope: BookingScope.past,
          state: const BookingsTabState(status: BookingsLoadStatus.loaded),
          cubit: cubit,
          cancellingIds: const {},
        ),
      ),
    );

    expect(find.byType(AppEmptyView), findsOneWidget);
  });

  testWidgets('shows a failure state with a retry action', (tester) async {
    when(
      () => repository.getBookings(BookingScope.upcoming, page: 1),
    ).thenAnswer((_) async => const Failed(NetworkFailure()));
    await tester.pumpWidget(
      _app(
        BookingsTabView(
          scope: BookingScope.upcoming,
          state: const BookingsTabState(
            status: BookingsLoadStatus.failure,
            failure: NetworkFailure(),
          ),
          cubit: cubit,
          cancellingIds: const {},
        ),
      ),
    );

    expect(find.byType(AppErrorView), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    verify(() => repository.getBookings(BookingScope.upcoming, page: 1)).called(1);
  });
}
