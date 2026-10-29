import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/booking_entity.dart';

enum BookingStatusState { idle, submitting, success, failure }

final class BookingState extends Equatable {
  const BookingState({
    this.status = BookingStatusState.idle,
    this.booking,
    this.failure,
  });

  final BookingStatusState status;
  final BookingEntity? booking;
  final Failure? failure;

  @override
  List<Object?> get props => [status, booking, failure];
}
