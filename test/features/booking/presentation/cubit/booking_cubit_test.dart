import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/domain/entities/booking_entity.dart';
import 'package:kora/features/booking/domain/entities/create_booking_params.dart';
import 'package:kora/features/booking/domain/repositories/booking_repository.dart';
import 'package:kora/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:kora/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:kora/features/booking/presentation/cubit/booking_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookingRepository extends Mock implements BookingRepository {}

BookingModel _fixtureBooking() {
  final envelope = jsonDecode(
    File('test/fixtures/booking_create_success_response.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return BookingModel.fromJson(envelope['data'] as Map<String, dynamic>);
}

void main() {
  late _MockBookingRepository repository;
  late BookingCubit cubit;
  late Completer<Result<BookingEntity>> pending;
  const params = CreateBookingParams(
    serviceId: 74,
    startsAt: '2026-10-31T10:00:00+02:00',
    answers: {},
  );

  setUp(() {
    repository = _MockBookingRepository();
    cubit = BookingCubit(CreateBookingUseCase(repository));
  });

  tearDown(() async => cubit.close());

  blocTest<BookingCubit, BookingState>(
    'emits submitting then success',
    build: () {
      when(
        () => repository.create(params),
      ).thenAnswer((_) async => Success(_fixtureBooking()));
      return cubit;
    },
    act: (cubit) => cubit.submit(params),
    expect: () => [
      const BookingState(status: BookingStatusState.submitting),
      BookingState(
        status: BookingStatusState.success,
        booking: _fixtureBooking(),
      ),
    ],
  );

  blocTest<BookingCubit, BookingState>(
    'emits failure without losing server message and code',
    build: () {
      when(() => repository.create(params)).thenAnswer(
        (_) async => const Failed(
          ValidationFailure(
            message: 'لديك حجز آخر في نفس الوقت',
            code: ApiErrorCodes.customerOverlap,
          ),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.submit(params),
    expect: () => [
      const BookingState(status: BookingStatusState.submitting),
      const BookingState(
        status: BookingStatusState.failure,
        failure: ValidationFailure(
          message: 'لديك حجز آخر في نفس الوقت',
          code: ApiErrorCodes.customerOverlap,
        ),
      ),
    ],
  );

  blocTest<BookingCubit, BookingState>(
    'ignores another submit while a request is pending',
    build: () {
      pending = Completer<Result<BookingEntity>>();
      when(
        () => repository.create(params),
      ).thenAnswer((_) => pending.future);
      return cubit;
    },
    act: (cubit) async {
      final first = cubit.submit(params);
      await Future<void>.delayed(Duration.zero);
      await cubit.submit(params);
      pending.complete(Success(_fixtureBooking()));
      await first;
    },
    expect: () => [
      const BookingState(status: BookingStatusState.submitting),
      BookingState(
        status: BookingStatusState.success,
        booking: _fixtureBooking(),
      ),
    ],
    verify: (_) => verify(() => repository.create(params)).called(1),
  );
}
