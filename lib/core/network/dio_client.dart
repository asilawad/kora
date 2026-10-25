import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../error/failure.dart';
import '../error/result.dart';

/// Unwrapped API envelope: `{ success, message, data, meta }`.
/// [data] stays raw; repositories parse it into models.
final class ApiResponse {
  const ApiResponse({this.data, this.meta = const {}, this.message});

  factory ApiResponse.fromEnvelope(Map<String, dynamic> json) {
    final meta = json[ApiResponseKeys.meta];
    final message = json[ApiResponseKeys.message];
    return ApiResponse(
      data: json[ApiResponseKeys.data],
      meta: meta is Map<String, dynamic> ? meta : const {},
      message: message is String ? message : null,
    );
  }

  final Object? data;
  final Map<String, dynamic> meta;
  final String? message;
}

/// Thin Dio wrapper that returns [Result]s and never throws.
///
/// Interceptors are injected. Register them in this order:
/// `AuthInterceptor`, then `ErrorInterceptor`.
final class DioClient {
  DioClient({
    required String languageCode,
    required Iterable<Interceptor> interceptors,
    HttpClientAdapter? httpClientAdapter,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: ApiConstants.baseUrl,
           connectTimeout: ApiConfig.connectTimeout,
           receiveTimeout: ApiConfig.receiveTimeout,
           sendTimeout: ApiConfig.sendTimeout,
           headers: {
             ApiHeaders.accept: ApiHeaders.json,
             ApiHeaders.contentType: ApiHeaders.json,
             ApiHeaders.acceptLanguage: languageCode,
           },
         ),
       ) {
    _dio.interceptors.addAll(interceptors);
    if (httpClientAdapter != null) {
      _dio.httpClientAdapter = httpClientAdapter;
    }
  }

  final Dio _dio;

  Future<Result<ApiResponse>> get(String path, {Map<String, dynamic>? query}) =>
      _send(() => _dio.get<Object?>(path, queryParameters: query));

  Future<Result<ApiResponse>> post(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) =>
      _send(() => _dio.post<Object?>(path, data: body, queryParameters: query));

  Future<Result<ApiResponse>> put(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) =>
      _send(() => _dio.put<Object?>(path, data: body, queryParameters: query));

  Future<Result<ApiResponse>> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) => _send(
    () => _dio.delete<Object?>(path, data: body, queryParameters: query),
  );

  Future<Result<ApiResponse>> _send(
    Future<Response<Object?>> Function() request,
  ) async {
    try {
      return _unwrap(await request());
    } on DioException catch (e) {
      final error = e.error;
      return Failed(
        error is Failure ? error : UnknownFailure(message: e.message),
      );
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  Result<ApiResponse> _unwrap(Response<Object?> response) {
    final body = response.data;
    if (body is! Map<String, dynamic>) {
      return const Failed(UnknownFailure());
    }
    if (body[ApiResponseKeys.success] == true) {
      return Success(ApiResponse.fromEnvelope(body));
    }
    final message = body[ApiResponseKeys.message];
    return Failed(
      ServerFailure(
        message: message is String ? message : null,
        statusCode: response.statusCode,
      ),
    );
  }
}
