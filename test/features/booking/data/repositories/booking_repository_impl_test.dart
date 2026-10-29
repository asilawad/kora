import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:kora/features/booking/domain/entities/booking_entity.dart';
import 'package:kora/features/booking/domain/entities/create_booking_params.dart';
import 'package:kora/features/booking/domain/repositories/booking_repository.dart';
import 'package:kora/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookingRemoteDataSource extends Mock
    implements BookingRemoteDataSource {}

class _MockBookingRepository extends Mock implements BookingRepository {}

Map<String, dynamic> _booking() {
  final envelope = jsonDecode(
    File('test/fixtures/booking_create_success_response.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return envelope['data'] as Map<String, dynamic>;
}

void main() {
  late _MockBookingRemoteDataSource remote;
  late BookingRepositoryImpl repository;
  late CreateBookingParams params;

  setUp(() {
    remote = _MockBookingRemoteDataSource();
    repository = BookingRepositoryImpl(remote);
    params = const CreateBookingParams(
      serviceId: 74,
      staffId: 55,
      startsAt: '2026-10-31T10:00:00+02:00',
      answers: {'players_count': 10},
    );
  });

  test('creates a booking and sends the API request fields', () async {
    when(() => remote.create(any())).thenAnswer(
      (_) async => Success(BookingModel.fromJson(_booking())),
    );
    final result = await repository.create(params);

    expect(result.dataOrNull, isA<BookingEntity>());
    final body = verify(() => remote.create(captureAny())).captured.single
        as Map<String, dynamic>;
    expect(body[ApiResponseKeys.serviceId], 74);
    expect(body[ApiResponseKeys.staffId], 55);
    expect(body[ApiResponseKeys.startsAt], params.startsAt);
    expect(body[ApiResponseKeys.paymentMethod], 'cash');
    expect(body.containsKey(ApiResponseKeys.notes), isFalse);
    expect(body.containsKey('coupon_code'), isFalse);
  });

  test('preserves overlap failure message and code', () async {
    const failure = ValidationFailure(
      message: 'لديك حجز آخر في نفس الوقت',
      code: ApiErrorCodes.customerOverlap,
      details: {},
    );
    when(
      () => remote.create(any()),
    ).thenAnswer((_) async => const Failed(failure));

    final result = await repository.create(params);

    expect(result.failureOrNull?.message, failure.message);
    expect(result.failureOrNull?.code, ApiErrorCodes.customerOverlap);
  });

  test('preserves generic failures', () async {
    const failure = NetworkFailure();
    when(
      () => remote.create(any()),
    ).thenAnswer((_) async => const Failed(failure));

    expect((await repository.create(params)).failureOrNull, same(failure));
  });

  test('use case delegates to the booking repository', () async {
    final mockRepository = _MockBookingRepository();
    final useCase = CreateBookingUseCase(mockRepository);
    when(
      () => mockRepository.create(params),
    ).thenAnswer((_) async => const Failed(NetworkFailure()));

    final result = await useCase(params);

    expect(result.failureOrNull, isA<NetworkFailure>());
    verify(() => mockRepository.create(params)).called(1);
  });
}
