import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import 'app_shell_dimensions.dart';
import 'floating_navigation_destination.dart';
import 'floating_navigation_item.dart';

final class FloatingNavigationBar extends StatelessWidget {
  const FloatingNavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<FloatingNavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) => Container(
    height: AppShellDimensions.navigationHeight,
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppShellDimensions.navigationInnerPadding,
    ),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      boxShadow: AppShadows.nav,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var index = 0; index < destinations.length; index++)
          FloatingNavigationItem(
            destination: destinations[index],
            selected: index == selectedIndex,
            onTap: () => onDestinationSelected(index),
          ),
      ],
    ),
  );
}
