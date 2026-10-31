import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/widgets/skeleton.dart';
import 'package:kora/core/widgets/skeleton_box.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shimmer skeleton builds without errors', (tester) async {
    await pumpApp(
      tester,
      const Skeleton(child: SkeletonBox(width: 120, height: 24)),
    );

    expect(find.byType(Skeleton), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
