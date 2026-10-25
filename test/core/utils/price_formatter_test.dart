import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/utils/price_formatter.dart';

void main() {
  test('omits decimals for whole prices', () {
    expect(formatPrice(12), '12');
  });

  test('prints two decimal places for fractional prices', () {
    expect(formatPrice(12.5), '12.50');
  });

  test('formats a price with two non-zero decimals', () {
    expect(formatPrice(119.99), '119.99');
  });
}
