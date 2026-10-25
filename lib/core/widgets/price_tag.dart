import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/price_formatter.dart';
import 'widget_dimensions.dart';

final class PriceTag extends StatelessWidget {
  const PriceTag({
    required this.price,
    required this.currencySymbol,
    this.salePrice,
    super.key,
  });

  final num price;
  final num? salePrice;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$currencySymbol ${formatPrice(salePrice ?? price)}',
        style: const TextStyle(color: AppColors.primary),
      ),
      if (salePrice != null) ...[
        const SizedBox(width: WidgetDimensions.spacingSmall),
        Text(
          '$currencySymbol ${formatPrice(price)}',
          style: const TextStyle(
            color: AppColors.textSecondary,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    ],
  );
}
