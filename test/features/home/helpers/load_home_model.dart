import 'dart:convert';
import 'dart:io';

import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';

Future<HomeDataModel> loadHomeModel() async {
  final envelope = jsonDecode(
    await File('test/fixtures/home_response.json').readAsString(),
  ) as Map<String, dynamic>;
  final data = envelope[ApiResponseKeys.data] as Map<String, dynamic>;
  return HomeDataModel.fromJson(data);
}
