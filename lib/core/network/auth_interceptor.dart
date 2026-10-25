import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

/// Attaches the stored bearer token to every request when one exists
/// (public endpoints simply ignore it), and clears it on HTTP 401 so an
/// expired session does not linger.
final class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.read();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiHeaders.authorization] =
          '${ApiHeaders.bearerPrefix} $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await _tokenStorage.clear();
    }
    handler.next(err);
  }
}
