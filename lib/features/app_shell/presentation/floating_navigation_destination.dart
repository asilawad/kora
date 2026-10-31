import 'package:flutter/material.dart';

final class FloatingNavigationDestination {
  const FloatingNavigationDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
