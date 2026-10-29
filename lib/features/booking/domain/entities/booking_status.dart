enum BookingStatus {
  confirmed,
  cancelled,
  arrived,
  inProgress,
  completed,
  unknown;

  static BookingStatus fromValue(String? value) => switch (value) {
    'confirmed' => BookingStatus.confirmed,
    'cancelled' => BookingStatus.cancelled,
    'arrived' => BookingStatus.arrived,
    'in_progress' => BookingStatus.inProgress,
    'completed' => BookingStatus.completed,
    _ => BookingStatus.unknown,
  };
}
