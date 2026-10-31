import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/theme/app_colors.dart';
import 'package:kora/core/widgets/chip_pill.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('uses the selected color for a selected pill', (tester) async {
    await pumpApp(
      tester,
      ChipPill(label: 'Selected', selected: true, onSelected: () {}),
    );

    final pill = tester.widget<AnimatedContainer>(
      find.descendant(
        of: find.byType(ChipPill),
        matching: find.byType(AnimatedContainer),
      ),
    );
    final decoration = pill.decoration! as BoxDecoration;
    expect(decoration.color, AppColors.primary);
  });
}
