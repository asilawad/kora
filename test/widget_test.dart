import 'package:flutter_test/flutter_test.dart';
import 'package:kora/app.dart';
import 'package:kora/core/di/injection.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/features/home/domain/entities/home_data_entity.dart';
import 'package:kora/features/home/domain/repositories/home_repository.dart';
import 'package:kora/features/home/domain/usecases/get_home_use_case.dart';
import 'package:kora/features/home/presentation/cubit/home_cubit.dart';
import 'package:kora/features/home/presentation/pages/home_page.dart';

class _TestHomeRepository implements HomeRepository {
  @override
  Future<Result<HomeDataEntity>> getHome() async =>
      const Failed(NetworkFailure());
}

void main() {
  setUp(() async {
    await sl.reset();
    sl.registerFactory<HomeCubit>(
      () => HomeCubit(GetHomeUseCase(_TestHomeRepository())),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('opens the home page directly', (WidgetTester tester) async {
    await tester.pumpWidget(const KoraApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
