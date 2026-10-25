import 'package:flutter/material.dart';

import 'widget_dimensions.dart';

final class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    child: isLoading
        ? SizedBox(
            width: WidgetDimensions.loaderSize,
            height: WidgetDimensions.loaderSize,
            child: CircularProgressIndicator(
              strokeWidth: WidgetDimensions.loaderStrokeWidth,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        : Text(label),
  );
}
