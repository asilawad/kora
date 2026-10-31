import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/events/bookings_events.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/segmented_tabs.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../auth/presentation/require_auth.dart';
import '../../domain/entities/booking_scope.dart';
import '../cubit/my_bookings_cubit.dart';
import '../my_bookings_dimensions.dart';
import '../cubit/my_bookings_state.dart';
import '../widgets/bookings_tab_view.dart';
import '../widgets/logout_confirmation_dialog.dart';
import '../widgets/signed_out_view.dart';

final class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<MyBookingsCubit>(),
    child: BlocProvider.value(
      value: sl<AuthCubit>(),
      child: const _MyBookingsContent(),
    ),
  );
}

final class _MyBookingsContent extends StatefulWidget {
  const _MyBookingsContent();

  @override
  State<_MyBookingsContent> createState() => _MyBookingsContentState();
}

final class _MyBookingsContentState extends State<_MyBookingsContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: BookingScope.values.length, vsync: this)
      ..addListener(_onTabChanged);
    BookingsEvents.changes.addListener(_onBookingsChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.read<AuthCubit>().state.isAuthenticated) {
        context.read<MyBookingsCubit>().ensureLoaded(BookingScope.upcoming);
      }
    });
  }

  void _onBookingsChanged() {
    if (!mounted) return;
    if (context.read<AuthCubit>().state.isAuthenticated) {
      context.read<MyBookingsCubit>().refreshLoaded();
    }
  }

  @override
  void dispose() {
    BookingsEvents.changes.removeListener(_onBookingsChanged);
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    if (context.read<AuthCubit>().state.isAuthenticated) {
      context.read<MyBookingsCubit>().ensureLoaded(
        BookingScope.values[_tabController.index],
      );
    }
  }

  Future<void> _login() async {
    if (await requireAuth(context) && mounted) {
      final cubit = context.read<MyBookingsCubit>();
      cubit.setSignedIn();
      await cubit.ensureLoaded(BookingScope.upcoming);
    }
  }

  Future<void> _logout() async {
    if (!await LogoutConfirmationDialog.show(context) || !mounted) return;
    await context.read<AuthCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              previous.status != current.status,
          listener: (context, state) {
            final cubit = context.read<MyBookingsCubit>();
            if (state.isAuthenticated) {
              cubit.setSignedIn();
              cubit.ensureLoaded(BookingScope.upcoming);
            } else {
              cubit.setSignedOut();
            }
          },
        ),
        BlocListener<MyBookingsCubit, MyBookingsState>(
          listenWhen: (previous, current) =>
              previous.messageId != current.messageId &&
              current.message != null,
          listener: (context, state) {
            final message = state.message;
            if (message == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    message.isEmpty
                        ? state.messageIsError
                            ? AppLocalizations.of(context)!.myBookingsCancelFailure
                            : AppLocalizations.of(context)!.myBookingsCancelSuccess
                        : message,
                  ),
                ),
              );
            context.read<MyBookingsCubit>().clearMessage();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.myBookingsTitle),
          actions: [
            if (context.watch<AuthCubit>().state.isAuthenticated)
              PopupMenuButton<String>(
                onSelected: (_) => _logout(),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AppRoutes.myBookingsName,
                    child: Text(l10n.myBookingsLogout),
                  ),
                ],
              ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              MyBookingsDimensions.segmentHeight +
                  MyBookingsDimensions.pagePadding,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                MyBookingsDimensions.pagePadding,
                0,
                MyBookingsDimensions.pagePadding,
                MyBookingsDimensions.cardSpacing,
              ),
              child: SegmentedTabs(
                controller: _tabController,
                labels: [l10n.myBookingsUpcoming, l10n.myBookingsPast],
              ),
            ),
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) => authState.isAuthenticated
              ? BlocBuilder<MyBookingsCubit, MyBookingsState>(
                  builder: (context, state) => TabBarView(
                    controller: _tabController,
                    children: [
                      BookingsTabView(
                        scope: BookingScope.upcoming,
                        state: state.upcoming,
                        cubit: context.read<MyBookingsCubit>(),
                        cancellingIds: state.cancellingIds,
                      ),
                      BookingsTabView(
                        scope: BookingScope.past,
                        state: state.past,
                        cubit: context.read<MyBookingsCubit>(),
                        cancellingIds: state.cancellingIds,
                      ),
                    ],
                  ),
                )
              : SignedOutView(onLogin: _login),
        ),
      ),
    );
  }
}
