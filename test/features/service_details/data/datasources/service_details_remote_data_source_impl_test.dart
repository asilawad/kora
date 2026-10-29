import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/constants/app_constants.dart';
import 'package:kora/core/network/dio_client.dart';
import 'package:kora/features/service_details/data/datasources/service_details_remote_data_source_impl.dart';

class _FixtureAdapter implements HttpClientAdapter {
  _FixtureAdapter(this.responses);

  final Map<String, Map<String, dynamic>> responses;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final response = responses.entries
        .firstWhere((entry) => options.uri.path.endsWith(entry.key))
        .value;
    return ResponseBody.fromString(
      jsonEncode(response),
      HttpStatus.ok,
      headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
    );
  }

  @override
  void close({bool force = false}) {}
}

Future<Map<String, dynamic>> _readEnvelope(String name) async =>
    jsonDecode(
          await File('test/fixtures/$name').readAsString(),
        )
        as Map<String, dynamic>;

void main() {
  test('uses expected endpoints and omits null staff filters', () async {
    final details = await _readEnvelope('service_details_82.json');
    final days = await _readEnvelope('availability_days_82.json');
    final slots = await _readEnvelope('availability_slots_82_any.json');
    final adapter = _FixtureAdapter({
      ApiConstants.serviceDetails(82): details,
      ApiConstants.availabilityDays: days,
      ApiConstants.availabilitySlots: slots,
    });
    final source = ServiceDetailsRemoteDataSourceImpl(
      DioClient(
        languageCode: AppConstants.defaultLocaleCode,
        interceptors: const [],
        httpClientAdapter: adapter,
      ),
    );

    final detailsResult = await source.getDetails(82);
    final daysResult = await source.getDays(82, days: 14);
    final slotsResult = await source.getSlots(
      82,
      date: '2026-10-30',
      staffId: 55,
    );
    final anySlotsResult = await source.getSlots(82, date: '2026-10-30');
    expect(detailsResult.isSuccess, isTrue, reason: '${detailsResult.failureOrNull}');
    expect(daysResult.isSuccess, isTrue, reason: '${daysResult.failureOrNull}');
    expect(slotsResult.isSuccess, isTrue, reason: '${slotsResult.failureOrNull}');
    expect(
      anySlotsResult.isSuccess,
      isTrue,
      reason: '${anySlotsResult.failureOrNull}',
    );

    expect(
      adapter.requests[0].uri.path.endsWith(ApiConstants.serviceDetails(82)),
      isTrue,
    );
    expect(
      adapter.requests[1].uri.path.endsWith(ApiConstants.availabilityDays),
      isTrue,
    );
    expect(adapter.requests[2].uri.path.endsWith(ApiConstants.availabilitySlots), isTrue);
    expect(adapter.requests[1].uri.queryParameters, {
      ApiQuery.serviceId: '82',
      ApiQuery.days: '14',
    });
    expect(adapter.requests[2].uri.queryParameters, {
      ApiQuery.serviceId: '82',
      ApiQuery.date: '2026-10-30',
      ApiQuery.staffId: '55',
    });
    expect(adapter.requests[3].uri.queryParameters, {
      ApiQuery.serviceId: '82',
      ApiQuery.date: '2026-10-30',
    });
  });
}
