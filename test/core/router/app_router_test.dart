import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/router/app_router.dart';
import 'package:kora/core/router/app_routes.dart';

void main() {
  test('registers the booking success and bookings routes', () {
    expect(
      AppRouter.router.namedLocation(AppRoutes.bookingSuccessName),
      AppRoutes.bookingSuccessPath,
    );
    expect(
      AppRouter.router.namedLocation(AppRoutes.myBookingsName),
      AppRoutes.myBookingsPath,
    );
  });
}
