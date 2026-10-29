import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/booking/domain/entities/booking_status.dart';
import 'package:kora/features/my_bookings/data/models/bookings_page_model.dart';

Map<String, dynamic> _fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  test('parses upcoming fixture and pagination metadata', () {
    final json = _fixture('test/fixtures/bookings_list_upcoming.json');
    final page = BookingsPageModel.fromResponse(
      data: json['data'],
      meta: json['meta'],
    );

    expect(page.items, hasLength(1));
    expect(page.items.single.canCancel, isTrue);
    expect(page.items.single.status, BookingStatus.confirmed);
    expect(page.page, 1);
    expect(page.lastPage, 1);
    expect(page.total, 1);
    expect(page.hasMore, isFalse);
  });

  test('parses past list and server-provided cancelled status', () {
    final json = _fixture('test/fixtures/bookings_list_past.json');
    final page = BookingsPageModel.fromResponse(
      data: json['data'],
      meta: json['meta'],
    );

    expect(page.items.single.status, BookingStatus.cancelled);
    expect(page.items.single.statusLabel, 'ملغي');
    expect(page.items.single.canCancel, isFalse);
  });

  test('parses cancellation response with nullable staff support', () {
    final json = _fixture('test/fixtures/booking_cancel_response.json');
    final page = BookingsPageModel.fromResponse(
      data: [json['data']],
      meta: const {'page': 1, 'last_page': 1, 'total': 1},
    );

    expect(page.items.single.status, BookingStatus.cancelled);
    expect(page.items.single.cancelReason, 'ظرف طارئ');
    expect(page.items.single.staff?.name, 'ملعب الزيتون');
  });
}
