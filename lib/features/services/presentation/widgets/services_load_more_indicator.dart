import 'package:flutter/material.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import 'services_dimensions.dart';

final class ServicesLoadMoreIndicator extends StatelessWidget {
  const ServicesLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: ServicesDimensions.footerHeight,
    child: AppLoader(),
  );
}
