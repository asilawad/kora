import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/di/injection.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/failure_message.dart';
import '../../../core/error/result.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loader.dart';
import '../../home/domain/entities/service_entity.dart';
import '../../home/domain/entities/place_entity.dart';
import '../../home/domain/providers/place_info_provider.dart';
import '../../home/domain/usecases/get_home_use_case.dart';
import '../../service_details/domain/entities/time_slot_entity.dart';
import '../../service_details/presentation/cubit/service_details_cubit.dart';
import 'cubit/booking_cubit.dart';
import 'cubit/booking_state.dart';
import 'booking_dimensions.dart';
import '../domain/entities/booking_entity.dart';
import '../domain/entities/create_booking_params.dart';
import 'widgets/booking_confirmation_content.dart';

final class BookingConfirmSheet extends StatefulWidget {
  const BookingConfirmSheet({
    required this.service,
    required this.date,
    required this.dayLabel,
    required this.slot,
    required this.staffId,
    required this.detailsCubit,
    super.key,
  });

  final ServiceEntity service;
  final String date;
  final String dayLabel;
  final TimeSlotEntity slot;
  final int? staffId;
  final ServiceDetailsCubit detailsCubit;

  static Future<BookingEntity?> show(
    BuildContext context, {
    required ServiceEntity service,
    required String date,
    required String dayLabel,
    required TimeSlotEntity slot,
    required int? staffId,
    required ServiceDetailsCubit detailsCubit,
  }) => showModalBottomSheet<BookingEntity>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
    builder: (_) => BlocProvider.value(
      value: detailsCubit,
      child: BlocProvider(
        create: (_) => sl<BookingCubit>(),
        child: BookingConfirmSheet(
          service: service,
          date: date,
          dayLabel: dayLabel,
          slot: slot,
          staffId: staffId,
          detailsCubit: detailsCubit,
        ),
      ),
    ),
  );

  @override
  State<BookingConfirmSheet> createState() => _BookingConfirmSheetState();
}

final class _BookingConfirmSheetState extends State<BookingConfirmSheet> {
  final TextEditingController _notesController = TextEditingController();
  PlaceEntity? _place;
  Failure? _placeFailure;
  Map<String, dynamic> _answers = const {};
  bool _isPlaceLoading = false;

  @override
  void initState() {
    super.initState();
    _place = sl<PlaceInfoProvider>().place;
    if (_place == null) _loadPlace();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadPlace() async {
    setState(() {
      _isPlaceLoading = true;
      _placeFailure = null;
    });
    final result = await sl<GetHomeUseCase>()();
    if (!mounted) return;
    switch (result) {
      case Success(data: final home):
        sl<PlaceInfoProvider>().update(home.place);
        setState(() => _place = home.place);
      case Failed(failure: final failure):
        setState(() => _placeFailure = failure);
    }
    setState(() => _isPlaceLoading = false);
  }

  void _submit() {
    context.read<BookingCubit>().submit(
      CreateBookingParams(
        serviceId: widget.service.id,
        staffId: widget.staffId,
        startsAt: widget.slot.startsAt,
        notes: _notesController.text,
        answers: _answers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<BookingCubit, BookingState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status != BookingStatusState.submitting,
      listener: (context, state) {
        if (state.status == BookingStatusState.success) {
          Navigator.of(context).pop(state.booking);
        }
        final failure = state.failure;
        if (failure?.code == ApiErrorCodes.slotUnavailable ||
            failure is SlotUnavailableFailure) {
          context.read<ServiceDetailsCubit>().selectDate(widget.date);
        }
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          BookingDimensions.sheetPadding,
          BookingDimensions.sheetPadding,
          BookingDimensions.sheetPadding,
          MediaQuery.viewInsetsOf(context).bottom +
              BookingDimensions.sheetPadding,
        ),
        child: _isPlaceLoading
            ? const SizedBox(
                height: BookingDimensions.placeLoaderHeight,
                child: AppLoader(),
              )
            : _place == null
            ? AppErrorView(
                message: _placeFailure?.message ??
                    _placeFailure?.localized(l10n) ??
                    l10n.errorUnknown,
                onRetry: _loadPlace,
              )
            : BookingConfirmationContent(
                service: widget.service,
                date: widget.date,
                dayLabel: widget.dayLabel,
                slot: widget.slot,
                staffName: _staffName,
                place: _place!,
                failure: context.select<BookingCubit, Failure?>(
                  (cubit) => cubit.state.failure,
                ),
                isSubmitting: context.select<BookingCubit, bool>(
                  (cubit) =>
                      cubit.state.status == BookingStatusState.submitting,
                ),
                onAnswersChanged: (value) => _answers = value,
                notesController: _notesController,
                onSubmit: _submit,
              ),
      ),
    );
  }

  String? get _staffName {
    for (final staff in widget.service.staff) {
      if (staff.id == widget.staffId) return staff.name;
    }
    return null;
  }
}
