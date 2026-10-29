import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../error/failure.dart';

/// Maps every [DioException] to a typed [Failure] and stores it in
/// `DioException.error`, so [DioClient] can return it inside a `Result`.
final class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err.copyWith(error: _toFailure(err)));
  }

  Failure _toFailure(DioException e) => switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutFailure(),
    DioExceptionType.connectionError => const NetworkFailure(),
    DioExceptionType.badResponse => _fromResponse(e.response),
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown =>
      e.error is SocketException
          ? const NetworkFailure()
          : UnknownFailure(message: e.message),
  };

  /// Parses `{ success: false, message, error: { code, details } }`.
  Failure _fromResponse(Response<dynamic>? response) {
    final status = response?.statusCode;
    final body = response?.data;
    final json = body is Map<String, dynamic>
        ? body
        : const <String, dynamic>{};
    final error = json[ApiResponseKeys.error];
    final errorJson = error is Map<String, dynamic>
        ? error
        : const <String, dynamic>{};

    final message = _asString(json[ApiResponseKeys.message]);
    final code = _asString(errorJson[ApiResponseKeys.code]);
    final details = errorJson[ApiResponseKeys.details];

    if (code == ApiErrorCodes.slotUnavailable) {
      return SlotUnavailableFailure(
        message: message,
        code: code,
        alternatives: _alternatives(details),
      );
    }
    if (status == HttpStatus.unprocessableEntity &&
        code == ApiErrorCodes.invalidCredentials) {
      return InvalidCredentialsFailure(message: message, code: code);
    }

    return switch (status) {
      HttpStatus.unauthorized => UnauthorizedFailure(
        message: message,
        code: code,
      ),
      HttpStatus.unprocessableEntity => ValidationFailure(
        message: message,
        code: code,
        details: _fieldDetails(details),
      ),
      _ => ServerFailure(message: message, code: code, statusCode: status),
    };
  }

  String? _asString(Object? value) => value is String ? value : null;

  Map<String, Object?> _fieldDetails(Object? details) {
    if (details is! Map) return const {};
    return {
      for (final entry in details.entries)
        if (entry.key is String) entry.key as String: entry.value,
    };
  }

  /// `error.details.alternatives` (item shape not yet confirmed -> raw).
  List<Object?> _alternatives(Object? details) {
    if (details is! Map<String, dynamic>) return const [];
    final alternatives = details[ApiResponseKeys.alternatives];
    return alternatives is List ? List<Object?>.of(alternatives) : const [];
  }
}
