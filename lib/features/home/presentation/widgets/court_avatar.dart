import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/color_parser.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/staff_entity.dart';
import 'home_dimensions.dart';

final class CourtAvatar extends StatelessWidget {
  const CourtAvatar({required this.court, super.key});

  final StaffEntity court;

  @override
  Widget build(BuildContext context) {
    final color = parseHexColor(court.color) ?? AppColors.primary;
    return SizedBox(
      width: HomeDimensions.courtItemWidth,
      child: Column(
        children: [
          Container(
            width: HomeDimensions.courtAvatarSize,
            height: HomeDimensions.courtAvatarSize,
            padding: const EdgeInsets.all(HomeDimensions.courtRingWidth),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(
                alpha: HomeDimensions.badgeOverlayOpacity,
              ),
              border: Border.all(
                color: color,
                width: HomeDimensions.courtRingWidth,
              ),
            ),
            child: ClipOval(
              child: AppNetworkImage(
                url: court.avatar,
                errorPlaceholder: Center(
                  child: Text(
                    court.initials,
                    style: TextStyle(color: color),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: HomeDimensions.smallSpacing),
          Text(
            court.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
