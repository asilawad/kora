import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/soft_card.dart';
import '../account_dimensions.dart';

final class AccountTile extends StatelessWidget {
  const AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.errorText : AppColors.textPrimary;
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: AccountDimensions.smallSpacing,
      ),
      child: SoftCard(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AccountDimensions.tileHeight - 32,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AccountDimensions.tileIconSize,
                color: destructive ? AppColors.errorText : AppColors.primary,
              ),
              const SizedBox(width: AccountDimensions.itemSpacing),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
