import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
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
  Widget build(BuildContext context) => Wrap(
    spacing: WidgetDimensions.spacingSmall,
    children: [
      Text(
        '$currencySymbol ${formatPrice(salePrice ?? price)}',
        style: AppTextStyles.price,
      ),
      if (salePrice != null) ...[
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
