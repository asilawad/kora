import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

import 'app_shell_dimensions.dart';

abstract final class AppShellNavigation {
  static StatefulNavigationShell? _shell;
  static final ValueNotifier<int> _homeScrollRequests = ValueNotifier(0);

  static ValueListenable<int> get homeScrollRequests => _homeScrollRequests;

  static void requestHomeScrollToTop() {
    _homeScrollRequests.value++;
  }

  static void attach(StatefulNavigationShell shell) {
    _shell = shell;
  }

  static void detach(StatefulNavigationShell shell) {
    if (identical(_shell, shell)) _shell = null;
  }

  static bool goToBookings() {
    final shell = _shell;
    if (shell == null) return false;
    shell.goBranch(AppShellDimensions.bookingsBranchIndex);
    return true;
  }
}
