class CreateBookingParams {
  const CreateBookingParams({
    required this.serviceId,
    required this.startsAt,
    required this.answers,
    this.staffId,
    this.notes,
  });

  static const String cashPaymentMethod = 'cash';

  final int serviceId;
  final int? staffId;
  final String startsAt;
  final String? notes;
  final Map<String, dynamic> answers;
  String get paymentMethod => cashPaymentMethod;
}
