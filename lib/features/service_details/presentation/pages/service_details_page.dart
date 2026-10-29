import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../auth/presentation/require_auth.dart';
import '../../../booking/presentation/booking_confirm_sheet.dart';
import '../../../home/domain/providers/place_info_provider.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../cubit/service_details_cubit.dart';
import '../cubit/service_details_state.dart';
import '../widgets/service_details_view.dart';
import '../widgets/sticky_book_bar.dart';

final class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({
    required this.serviceId,
    this.initialService,
    this.currencySymbol = '',
    super.key,
  });

  final int serviceId;
  final ServiceEntity? initialService;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => sl<ServiceDetailsCubit>()..load(serviceId),
    child: _ServiceDetailsPageView(
      initialService: initialService,
      currencySymbol: currencySymbol,
    ),
  );
}

final class _ServiceDetailsPageView extends StatelessWidget {
  const _ServiceDetailsPageView({
    required this.initialService,
    required this.currencySymbol,
  });

  final ServiceEntity? initialService;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) => ServiceDetailsView(
          state: state,
          initialService: initialService,
          currencySymbol: currencySymbol,
          onRetryDetails: context.read<ServiceDetailsCubit>().retryDetails,
          onSelectStaff: context.read<ServiceDetailsCubit>().selectStaff,
          onSelectDate: context.read<ServiceDetailsCubit>().selectDate,
          onSelectSlot: context.read<ServiceDetailsCubit>().selectSlot,
          onRetryDays: context.read<ServiceDetailsCubit>().retryDays,
          onRetrySlots: context.read<ServiceDetailsCubit>().retrySlots,
        ),
      ),
    ),
    bottomNavigationBar: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) => StickyBookBar(
        service: state.service ?? initialService,
        currencySymbol: currencySymbol.isNotEmpty
            ? currencySymbol
            : sl<PlaceInfoProvider>().place?.currencySymbol ?? '',
        slot: state.selectedSlot,
        onBook: (slot) => _book(context, state, slot),
      ),
    ),
  );

  Future<void> _book(
    BuildContext context,
    ServiceDetailsState state,
    TimeSlotEntity slot,
  ) async {
    if (!await requireAuth(context) || !context.mounted) return;
    final service = state.service ?? initialService;
    final date = state.selectedDate;
    if (service == null || date == null) return;
    final detailsCubit = context.read<ServiceDetailsCubit>();
    final booking = await BookingConfirmSheet.show(
      context,
      service: service,
      date: date,
      dayLabel: _dayLabel(state, date),
      slot: slot,
      staffId: state.resolvedStaffId,
      detailsCubit: detailsCubit,
    );
    if (booking == null || !context.mounted) return;
    await detailsCubit.selectDate(date);
    if (!context.mounted) return;
    context.pushNamed(AppRoutes.bookingSuccessName, extra: booking);
  }

  String _dayLabel(ServiceDetailsState state, String date) {
    for (final day in state.days) {
      if (day.date == date) return day.label;
    }
    return date;
  }
}
