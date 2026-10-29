import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/my_bookings/data/datasources/my_bookings_remote_data_source.dart';
import 'package:kora/features/my_bookings/data/models/bookings_page_model.dart';
import 'package:kora/features/my_bookings/data/repositories/my_bookings_repository_impl.dart';
import 'package:kora/features/my_bookings/domain/entities/booking_scope.dart';
import 'package:kora/features/my_bookings/domain/usecases/cancel_booking_use_case.dart';
import 'package:kora/features/my_bookings/domain/usecases/get_bookings_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemoteDataSource extends Mock implements MyBookingsRemoteDataSource {}

Map<String, dynamic> _fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

BookingModel _booking() {
  final json = _fixture('test/fixtures/booking_cancel_response.json');
  return BookingModel.fromJson(json['data'] as Map<String, dynamic>);
}

void main() {
  late _MockRemoteDataSource remote;
  late MyBookingsRepositoryImpl repository;

  setUp(() {
    remote = _MockRemoteDataSource();
    repository = MyBookingsRepositoryImpl(remote);
  });

  test('gets list page and preserves metadata', () async {
    final json = _fixture('test/fixtures/bookings_list_upcoming.json');
    final page = BookingsPageModel.fromResponse(
      data: json['data'],
      meta: json['meta'],
    );
    when(
      () => remote.getBookings(BookingScope.upcoming, page: 1),
    ).thenAnswer((_) async => Success(page));

    final result = await GetBookingsUseCase(repository)(BookingScope.upcoming);

    expect(result.dataOrNull?.items, hasLength(1));
    expect(result.dataOrNull?.lastPage, 1);
  });

  test('preserves not-cancellable server message and code', () async {
    final failureBody = _fixture(
      'test/fixtures/booking_not_cancellable_response.json',
    );
    final failure = ValidationFailure(
      message: failureBody[ApiResponseKeys.message] as String,
      code: (failureBody[ApiResponseKeys.error]
              as Map<String, dynamic>)[ApiResponseKeys.code]
          as String,
    );
    when(
      () => remote.cancelBooking(2791),
    ).thenAnswer((_) async => Failed(failure));

    final result = await CancelBookingUseCase(repository)(2791);

    expect(result.failureOrNull?.message, 'لا يمكن إلغاء هذا الحجز الآن');
    expect(result.failureOrNull?.code, ApiErrorCodes.bookingNotCancellable);
  });

  test('cancellation use case delegates optional reason', () async {
    when(
      () => remote.cancelBooking(2791, reason: 'schedule change'),
    ).thenAnswer((_) async => Success(_booking()));

    final result = await CancelBookingUseCase(repository)(
      2791,
      reason: 'schedule change',
    );

    expect(result.dataOrNull?.statusLabel, 'ملغي');
    verify(() => remote.cancelBooking(2791, reason: 'schedule change')).called(1);
  });
}
