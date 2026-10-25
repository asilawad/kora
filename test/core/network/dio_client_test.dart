import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/network/dio_client.dart';

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter(this._body);

  final Map<String, Object?> _body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode(_body),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  test('unwraps a successful response envelope', () async {
    final client = _client({
      'success': true,
      'data': {'id': 4},
      'meta': {'page': 1},
    });

    final result = await client.get('/test');

    expect(result, isA<Success<ApiResponse>>());
    final response = (result as Success<ApiResponse>).data;
    expect(response.data, {'id': 4});
    expect(response.meta, {'page': 1});
  });

  test('converts an unsuccessful envelope to ServerFailure', () async {
    final client = _client({
      'success': false,
      'message': 'Unavailable',
    });

    final result = await client.get('/test');

    expect(result, isA<Failed<ApiResponse>>());
    expect((result as Failed<ApiResponse>).failure, isA<ServerFailure>());
    expect(
      (result.failureOrNull as ServerFailure).message,
      'Unavailable',
    );
  });
}

DioClient _client(Map<String, Object?> body) => DioClient(
  languageCode: 'ar',
  interceptors: [],
  httpClientAdapter: _FakeHttpClientAdapter(body),
);
