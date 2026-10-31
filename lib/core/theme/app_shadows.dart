import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A101828),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x0F101828),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static const List<BoxShadow> raised = [
    BoxShadow(
      color: Color(0x1A101828),
      offset: Offset(0, 12),
      blurRadius: 32,
    ),
  ];

  static const List<BoxShadow> nav = [
    BoxShadow(
      color: Color(0x14101828),
      offset: Offset(0, -4),
      blurRadius: 24,
    ),
  ];
}
