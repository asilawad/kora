import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import 'auth_bottom_sheet.dart';
import 'cubit/auth_cubit.dart';

Future<bool> requireAuth(BuildContext context) async {
  if (sl<AuthCubit>().state.isAuthenticated) return true;
  return await AuthBottomSheet.show(context) ?? false;
}
