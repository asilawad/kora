import 'dart:convert';
import 'dart:io';

import 'package:kora/features/services/data/models/services_page_model.dart';

Future<ServicesPageModel> loadServicesPage({
  String fixture = 'services_page_response.json',
}) async {
  final json = jsonDecode(
    await File('test/fixtures/$fixture').readAsString(),
  ) as Map<String, dynamic>;
  return ServicesPageModel.fromJson(json);
}
