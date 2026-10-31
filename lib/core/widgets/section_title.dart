import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widget_dimensions.dart';

final class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    this.trailingText,
    this.onTrailingTap,
    super.key,
  });

  final String title;
  final String? trailingText;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: WidgetDimensions.sectionAccentWidth,
        height: WidgetDimensions.sectionAccentHeight,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(
            WidgetDimensions.sectionAccentRadius,
          ),
        ),
      ),
      const SizedBox(width: WidgetDimensions.sectionAccentGap),
      Expanded(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      if (trailingText != null)
        TextButton(
          onPressed: onTrailingTap,
          style: TextButton.styleFrom(
            minimumSize: const Size(
              WidgetDimensions.sectionActionMinWidth,
              WidgetDimensions.tapTarget,
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: WidgetDimensions.sectionActionHorizontalPadding,
            ),
          ),
          child: Text(trailingText!),
        ),
    ],
  );
}
