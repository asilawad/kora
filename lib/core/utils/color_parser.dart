import 'package:flutter/material.dart';

const int _opaqueAlpha = 0xFF000000;

Color? parseHexColor(String? hex) {
  if (hex == null) return null;

  final normalized = hex.startsWith('#') ? hex.substring(1) : hex;
  if (normalized.length != 6) return null;

  final value = int.tryParse(normalized, radix: 16);
  return value == null ? null : Color(_opaqueAlpha | value);
}
