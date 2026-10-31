import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/soft_card.dart';
import '../../../../core/widgets/status_pill.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../account_dimensions.dart';

final class AccountProfileCard extends StatelessWidget {
  const AccountProfileCard({required this.user, super.key});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final reliability = user.reliability;
    return SoftCard(
      child: Row(
        children: [
          Container(
            width: AccountDimensions.avatarSize,
            height: AccountDimensions.avatarSize,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              user.initials.isEmpty ? '?' : user.initials,
              style: theme.titleLarge?.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(width: AccountDimensions.itemSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: theme.titleMedium),
                Text(
                  user.email,
                  style: theme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (user.phone.isNotEmpty)
                  Text(
                    user.phone,
                    style: theme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                if (reliability != null) ...[
                  const SizedBox(height: AccountDimensions.smallSpacing),
                  StatusPill(
                    label: reliability.label,
                    variant: StatusPillVariant.info,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
