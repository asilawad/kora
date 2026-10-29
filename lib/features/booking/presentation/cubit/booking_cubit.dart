import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/create_booking_params.dart';
import '../../domain/usecases/create_booking_use_case.dart';
import 'booking_state.dart';

final class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._createBooking) : super(const BookingState());

  final CreateBookingUseCase _createBooking;

  Future<void> submit(CreateBookingParams params) async {
    if (state.status == BookingStatusState.submitting) return;
    emit(const BookingState(status: BookingStatusState.submitting));
    switch (await _createBooking(params)) {
      case Success<BookingEntity>(:final data):
        emit(BookingState(status: BookingStatusState.success, booking: data));
      case Failed<BookingEntity>(:final failure):
        emit(
          BookingState(status: BookingStatusState.failure, failure: failure),
        );
    }
  }

  void reset() => emit(const BookingState());
}
