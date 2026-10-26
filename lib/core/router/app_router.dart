import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/services/presentation/pages/services_page_arguments.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.homePath,
    routes: [
      GoRoute(
        path: AppRoutes.homePath,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.servicesPath,
        name: AppRoutes.servicesName,
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
    ],
  );
}
