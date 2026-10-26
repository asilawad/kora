import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kora/core/di/injection.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/presentation/cubit/home_cubit.dart';
import 'package:kora/features/home/presentation/cubit/home_state.dart';
import 'package:kora/features/home/presentation/pages/home_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/load_home_model.dart';
import '../../../../helpers/pump_app.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late _MockHomeCubit cubit;
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  setUp(() async {
    await sl.reset();
    cubit = _MockHomeCubit();
    sl.registerFactory<HomeCubit>(() => cubit);
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.close()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  void showState(HomeState state) {
    whenListen(cubit, const Stream<HomeState>.empty(), initialState: state);
  }

  testWidgets('shows inline loader while loading', (tester) async {
    showState(const HomeLoading());
    await pumpApp(tester, const HomePage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows failure and retries on tap', (tester) async {
    showState(const HomeFailure(NetworkFailure()));
    await pumpApp(tester, const HomePage());

    expect(find.text('إعادة المحاولة'), findsOneWidget);
    await tester.tap(find.text('إعادة المحاولة'));

    verify(() => cubit.load()).called(2);
  });

  testWidgets('renders loaded home data', (tester) async {
    showState(HomeLoaded(home));
    await pumpApp(tester, const HomePage());

    expect(find.text(home.place.name), findsWidgets);
  });
}
