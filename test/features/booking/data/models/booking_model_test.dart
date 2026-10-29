import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/domain/entities/booking_status.dart';

Map<String, dynamic> _fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  test('parses the real create response and staff details', () {
    final envelope = _fixture('test/fixtures/booking_create_success_response.json');
    final model = BookingModel.fromJson(envelope['data'] as Map<String, dynamic>);

    expect(model.id, 2793);
    expect(model.status, BookingStatus.confirmed);
    expect(model.staff?.name, 'ملعب الزيتون');
    expect(model.answersDisplay.last.value, 10);
    expect(model.total, 120);
  });

  test('parses the real cancel response and cancelled status', () {
    final envelope = _fixture('test/fixtures/booking_cancel_response.json');
    final model = BookingModel.fromJson(envelope['data'] as Map<String, dynamic>);

    expect(model.status, BookingStatus.cancelled);
    expect(model.cancelReason, 'ظرف طارئ');
    expect(model.cancelledAt, '2026-10-29T09:14:59+00:00');
    expect(model.staff?.id, 55);
  });

  test('accepts a booking response without a staff object', () {
    final envelope = _fixture('test/fixtures/booking_create_success_response.json');
    final data = Map<String, dynamic>.from(envelope['data'] as Map)
      ..remove('staff');

    expect(BookingModel.fromJson(data).staff, isNull);
  });

  test('uses unknown for unrecognized booking statuses', () {
    final envelope = _fixture('test/fixtures/booking_create_success_response.json');
    final data = Map<String, dynamic>.from(envelope['data'] as Map)
      ..['status'] = 'future_status';

    expect(BookingModel.fromJson(data).status, BookingStatus.unknown);
  });
}
