import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora/app.dart';
import 'package:kora/core/di/injection.dart';
import 'package:kora/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kora/features/auth/presentation/cubit/auth_state.dart';
import 'package:kora/features/service_details/presentation/widgets/sticky_book_bar.dart';
import 'package:kora/features/home/presentation/widgets/featured_service_card.dart';
import 'package:kora/features/service_details/presentation/widgets/service_details_view.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_state.dart';

import 'app_flow_harness.dart';

const double _homeScrollStep = 500;
const int _homeScrollAttempts = 4;

Future<void> pumpKora(WidgetTester tester, AppFlowHarness harness) async {
  await harness.register();
  await tester.pumpWidget(const KoraApp());
  await pumpFrames(tester);
}

Future<void> pumpFrames(WidgetTester tester) async {
  for (var index = 0; index < 8; index++) {
    await tester.pump(const Duration(milliseconds: 150));
  }
}

Future<void> chooseServiceCourtDayAndSlot(
  WidgetTester tester,
  AppFlowHarness harness,
) async {
  final homeScroll = find.byType(CustomScrollView).first;
  for (var attempt = 0;
      attempt < _homeScrollAttempts &&
          find.byType(FeaturedServiceCard).evaluate().isEmpty;
      attempt++) {
    await tester.drag(homeScroll, const Offset(0, -_homeScrollStep));
    await pumpFrames(tester);
  }
  final serviceCard = find.byType(FeaturedServiceCard).first;
  await tester.ensureVisible(serviceCard);
  await tester.tap(serviceCard);
  await pumpFrames(tester);
  final detailView = find.byType(ServiceDetailsView);
  expect(detailView, findsOneWidget);
  final detailsState = tester.element(detailView).read<ServiceDetailsCubit>().state;
  expect(detailsState.detailsStatus, ServiceDetailsLoadStatus.loaded);
  expect(detailsState.service?.staff, isNotEmpty);
  final cubit = tester.element(detailView).read<ServiceDetailsCubit>();
  await cubit.selectStaff(harness.details.service.staff.first.id);
  final day = harness.days.firstWhere((item) => item.open && item.slotsCount > 0);
  await cubit.selectDate(day.date);
  cubit.selectSlot(harness.slots.first);
  await pumpFrames(tester);
  expect(find.byType(StickyBookBar), findsOneWidget);
}

Future<void> authenticateInSheet(WidgetTester tester) async {
  final fields = find.byType(TextField);
  await tester.enterText(fields.at(0), 'member@example.com');
  await tester.enterText(fields.at(1), 'password');
  await tester.tap(find.byType(ElevatedButton).last);
  await pumpFrames(tester);
  expect(sl<AuthCubit>().state.status, AuthStatus.authenticated);
}
