import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_shell/presentation/app_shell.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/services/presentation/pages/services_page_arguments.dart';
import '../../features/service_details/presentation/pages/service_details_page.dart';
import '../../features/booking/domain/entities/booking_entity.dart';
import '../../features/booking/presentation/pages/booking_success_page.dart';
import '../../features/my_bookings/presentation/pages/my_bookings_page.dart';
import '../../features/home/domain/entities/service_entity.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.homePath,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.homePath,
                name: AppRoutes.homeName,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myBookingsPath,
                name: AppRoutes.myBookingsName,
                builder: (context, state) => const MyBookingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.servicesPath,
        name: AppRoutes.servicesName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra;
          final arguments = extra is ServicesPageArguments
              ? extra
              : const ServicesPageArguments();
          return ServicesPage(
            categories: arguments.categories,
            initialCategoryId: arguments.initialCategoryId,
            autofocusSearch: arguments.autofocusSearch,
            currencySymbol: arguments.currencySymbol,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.serviceDetailsPath,
        name: AppRoutes.serviceDetailsName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra;
          return ServiceDetailsPage(
            serviceId: int.parse(
              state.pathParameters[AppRoutes.serviceIdParameter]!,
            ),
            initialService: extra is ServiceEntity ? extra : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingSuccessPath,
        name: AppRoutes.bookingSuccessName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BookingSuccessPage(
          booking: state.extra! as BookingEntity,
        ),
      ),
    ],
  );
}
