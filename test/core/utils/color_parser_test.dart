import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/utils/color_parser.dart';

void main() {
  test('parses a prefixed hex color', () {
    expect(parseHexColor('#0EA5A4'), const Color(0xFF0EA5A4));
  });

  test('parses hex color without a prefix', () {
    expect(parseHexColor('0EA5A4'), const Color(0xFF0EA5A4));
  });

  test('returns null for invalid input', () {
    expect(parseHexColor('#GGGGGG'), isNull);
  });

  test('returns null for null input', () {
    expect(parseHexColor(null), isNull);
  });
}
