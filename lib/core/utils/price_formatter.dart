const int _priceDecimalPlaces = 2;

String formatPrice(num value) => value % 1 == 0
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(_priceDecimalPlaces);
