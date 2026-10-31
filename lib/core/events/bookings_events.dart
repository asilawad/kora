import 'package:flutter/foundation.dart';

/// Lightweight app-wide signal: bookings changed (created or tab revisited).
abstract final class BookingsEvents {
  static final ValueNotifier<int> _changes = ValueNotifier<int>(0);

  static ValueListenable<int> get changes => _changes;

  static void notifyChanged() => _changes.value++;
}
