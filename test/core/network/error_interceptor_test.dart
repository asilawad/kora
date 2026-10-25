import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/network/error_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class _MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class _FakeDioException extends Fake implements DioException {}

void main() {
  late ErrorInterceptor interceptor;
  late _MockErrorInterceptorHandler handler;
  late DioException mappedException;

  setUpAll(() {
    registerFallbackValue(_FakeDioException());
  });

  setUp(() {
    interceptor = ErrorInterceptor();
    handler = _MockErrorInterceptorHandler();
    when(() => handler.next(any())).thenReturn(null);
  });

  Future<Failure> mapException(DioException exception) async {
    interceptor.onError(exception, handler);
    final captured = verify(() => handler.next(captureAny())).captured.single;
    mappedException = captured as DioException;
    return mappedException.error! as Failure;
  }

  test('maps timeouts to TimeoutFailure', () async {
    final failure = await mapException(
      DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.receiveTimeout,
      ),
    );

    expect(failure, isA<TimeoutFailure>());
  });

  test('maps connection errors to NetworkFailure', () async {
    final failure = await mapException(
      DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionError,
      ),
    );

    expect(failure, isA<NetworkFailure>());
  });

  test('maps unavailable slots and keeps alternatives', () async {
    final failure = await mapException(
      _badResponse(
        HttpStatus.conflict,
        <String, Object?>{
          'message': 'Slot was taken',
          'error': <String, Object?>{
            'code': ApiErrorCodes.slotUnavailable,
            'details': <String, Object?>{
              'alternatives': ['10:00', '11:00'],
            },
          },
        },
      ),
    );

    expect(failure, isA<SlotUnavailableFailure>());
    expect((failure as SlotUnavailableFailure).alternatives, ['10:00', '11:00']);
  });

  test('maps unauthorized responses to UnauthorizedFailure', () async {
    final failure = await mapException(
      _badResponse(HttpStatus.unauthorized, _errorBody()),
    );

    expect(failure, isA<UnauthorizedFailure>());
  });

  test('maps validation responses to ValidationFailure', () async {
    final failure = await mapException(
      _badResponse(HttpStatus.unprocessableEntity, _errorBody()),
    );

    expect(failure, isA<ValidationFailure>());
  });

  test('maps other bad responses to ServerFailure', () async {
    final failure = await mapException(
      _badResponse(HttpStatus.internalServerError, _errorBody()),
    );

    expect(failure, isA<ServerFailure>());
  });
}

DioException _badResponse(int statusCode, Object data) {
  final requestOptions = RequestOptions(path: '/');
  return DioException(
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );
}

Map<String, Object?> _errorBody() => {
  'message': 'Request failed',
  'error': <String, Object?>{'code': 'OTHER'},
};
