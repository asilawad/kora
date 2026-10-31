import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/events/bookings_events.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import 'app_shell_dimensions.dart';
import 'app_shell_navigation.dart';
import 'floating_navigation_bar.dart';
import 'floating_navigation_destination.dart';

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
        extendBody: true,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: AppShellDimensions.navigationContentBottom,
            ),
            child: widget.navigationShell,
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppShellDimensions.navigationHorizontalMargin,
              end: AppShellDimensions.navigationHorizontalMargin,
              bottom: AppShellDimensions.navigationBottomMargin,
            ),
            child: FloatingNavigationBar(
              selectedIndex: widget.navigationShell.currentIndex,
              destinations: [
                FloatingNavigationDestination(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_rounded,
                  label: l10n.navigationHome,
                ),
                FloatingNavigationDestination(
                  icon: Icons.sports_soccer_outlined,
                  selectedIcon: Icons.sports_soccer_rounded,
                  label: l10n.navigationServices,
                ),
                FloatingNavigationDestination(
                  icon: Icons.calendar_month_outlined,
                  selectedIcon: Icons.calendar_month_rounded,
                  label: l10n.navigationBookings,
                ),
                FloatingNavigationDestination(
                  icon: Icons.person_outline_rounded,
                  selectedIcon: Icons.person_rounded,
                  label: l10n.navigationAccount,
                ),
              ],
              onDestinationSelected: (index) {
                final isReselect =
                    index == widget.navigationShell.currentIndex;
                widget.navigationShell.goBranch(
                  index,
                  initialLocation: isReselect,
                );
                if (index == AppShellDimensions.bookingsBranchIndex) {
                  BookingsEvents.notifyChanged();
                }
                if (isReselect &&
                    index == AppShellDimensions.homeBranchIndex) {
                  AppShellNavigation.requestHomeScrollToTop();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
