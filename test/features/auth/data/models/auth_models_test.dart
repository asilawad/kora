import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/auth/data/models/auth_session_model.dart';
import 'package:kora/features/auth/data/models/user_model.dart';

Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('parses login and registration session fixtures', () {
    final login = AuthSessionModel.fromJson(
      _fixture('auth_login_response.json')['data'] as Map<String, dynamic>,
    );
    final register = AuthSessionModel.fromJson(
      _fixture('auth_register_response.json')['data'] as Map<String, dynamic>,
    );

    expect(login.token, 'TEST_TOKEN');
    expect(login.user.id, 84);
    expect(register.user.roleLabel, 'عميل');
    expect(register.user.avatar, isNull);
    expect(register.user.cohort, isNull);
  });

  test('parses current-user reliability data', () {
    final user = UserModel.fromJson(
      _fixture('auth_me_response.json')['data'] as Map<String, dynamic>,
    );

    expect(user.reliability?.score, 100);
    expect(user.reliability?.completed, 0);
    expect(user.reliability?.noShows, 0);
    expect(user.reliability?.lateCancellations, 0);
    expect(user.reliability?.total, 0);
  });
}
