import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/network/dio_client.dart';
import 'package:kora/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:kora/features/auth/data/models/login_request_model.dart';
import 'package:kora/features/auth/domain/entities/login_params.dart';

final class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter(this.body);

  final String body;
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromString(
      body,
      HttpStatus.ok,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('posts auth parameters to the place-scoped endpoint', () async {
    final body = File('test/fixtures/auth_login_response.json')
        .readAsStringSync();
    final adapter = _CapturingAdapter(body);
    final client = DioClient(
      languageCode: 'ar',
      interceptors: const [],
      httpClientAdapter: adapter,
    );
    final source = AuthRemoteDataSourceImpl(client);
    final request = LoginRequestModel(
      const LoginParams(email: 'student@example.com', password: 'Secret123'),
    );

    final result = await source.login(request.toJson());

    expect(result.isSuccess, isTrue);
    expect(adapter.request?.path, ApiConstants.login);
    expect(adapter.request?.data, {
      'email': 'student@example.com',
      'password': 'Secret123',
      'device_name': 'kora-app',
    });
    expect(jsonDecode(body)['success'], isTrue);
  });
}
