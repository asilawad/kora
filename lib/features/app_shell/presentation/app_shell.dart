import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import 'app_shell_dimensions.dart';
import 'app_shell_navigation.dart';

final class AppShell extends StatefulWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<AppShell> createState() => _AppShellState();
}

final class _AppShellState extends State<AppShell> {
  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    AppShellNavigation.detach(oldWidget.navigationShell);
  }

  @override
  void dispose() {
    AppShellNavigation.detach(widget.navigationShell);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppShellNavigation.attach(widget.navigationShell);
    final l10n = AppLocalizations.of(context)!;
    final isHome = widget.navigationShell.currentIndex ==
        AppShellDimensions.homeBranchIndex;
    return PopScope<void>(
      canPop: isHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !isHome) {
          widget.navigationShell.goBranch(
            AppShellDimensions.homeBranchIndex,
            initialLocation: true,
          );
        }
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (index) {
            final isReselect = index == widget.navigationShell.currentIndex;
            widget.navigationShell.goBranch(
              index,
              initialLocation: isReselect,
            );
            if (isReselect &&
                index == AppShellDimensions.homeBranchIndex) {
              AppShellNavigation.requestHomeScrollToTop();
            }
          },
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primarySoft,
          elevation: AppShellDimensions.navigationElevation,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l10n.navigationHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.calendar_month_outlined),
              selectedIcon: const Icon(Icons.calendar_month),
              label: l10n.navigationBookings,
            ),
          ],
        ),
      ),
    );
  }
}
