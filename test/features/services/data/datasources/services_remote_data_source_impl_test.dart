import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/constants/app_constants.dart';
import 'package:kora/core/network/dio_client.dart';
import 'package:kora/features/services/data/datasources/services_remote_data_source_impl.dart';
import 'package:kora/features/services/domain/entities/service_sort.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';

class _CapturingAdapter implements HttpClientAdapter {
  Map<String, String>? queryParameters;
  late Map<String, dynamic> envelope;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    queryParameters = options.uri.queryParameters;
    return ResponseBody.fromString(
      jsonEncode(envelope),
      HttpStatus.ok,
      headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late Map<String, dynamic> fixture;
  late _CapturingAdapter adapter;
  late ServicesRemoteDataSourceImpl source;

  setUpAll(() async {
    fixture = jsonDecode(
      await File('test/fixtures/services_page_response.json').readAsString(),
    ) as Map<String, dynamic>;
  });

  setUp(() {
    adapter = _CapturingAdapter()
      ..envelope = {
        ApiResponseKeys.success: true,
        ApiResponseKeys.data: fixture[ApiResponseKeys.data],
        ApiResponseKeys.meta: fixture[ApiResponseKeys.meta],
      };
    source = ServicesRemoteDataSourceImpl(
      DioClient(
        languageCode: AppConstants.defaultLocaleCode,
        interceptors: const [],
        httpClientAdapter: adapter,
      ),
    );
  });

  test('builds query parameters and omits empty search', () async {
    await source.getServices(
      const ServicesQuery(categoryId: 46, page: 2, search: '  '),
    );

    expect(adapter.queryParameters, {
      ApiQuery.page: '2',
      ApiQuery.perPage: '15',
      ApiQuery.sort: 'popular',
      ApiQuery.categoryId: '46',
    });
  });

  test('adds a non-empty search and sort order', () async {
    await source.getServices(
      const ServicesQuery(search: ' futsal ', sort: ServiceSort.priceAsc),
    );

    expect(adapter.queryParameters?[ApiQuery.search], 'futsal');
    expect(adapter.queryParameters?[ApiQuery.sort], 'price');
    expect(adapter.queryParameters?[ApiQuery.order], 'asc');
  });
}
