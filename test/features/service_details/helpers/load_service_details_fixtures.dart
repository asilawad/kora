import 'dart:convert';
import 'dart:io';

import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/features/service_details/data/models/availability_day_model.dart';
import 'package:kora/features/service_details/data/models/service_details_model.dart';
import 'package:kora/features/service_details/data/models/time_slot_model.dart';

Future<Map<String, dynamic>> loadFixture(String name) async =>
    jsonDecode(
          await File('test/fixtures/$name').readAsString(),
        )
        as Map<String, dynamic>;

Future<ServiceDetailsModel> loadDetailsFixture(String name) async {
  final envelope = await loadFixture(name);
  return ServiceDetailsModel.fromJson(
    envelope[ApiResponseKeys.data] as Map<String, dynamic>,
  );
}

Future<List<AvailabilityDayModel>> loadDaysFixture(String name) async {
  final envelope = await loadFixture(name);
  return (envelope[ApiResponseKeys.data] as List)
      .map((item) => AvailabilityDayModel.fromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

Future<List<TimeSlotModel>> loadSlotsFixture(String name) async {
  final envelope = await loadFixture(name);
  return (envelope[ApiResponseKeys.data] as List)
      .map((item) => TimeSlotModel.fromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}
