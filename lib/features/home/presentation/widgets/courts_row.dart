import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/entities/staff_entity.dart';
import 'court_avatar.dart';
import 'home_dimensions.dart';
import 'section_header.dart';

final class CourtsRow extends StatelessWidget {
  const CourtsRow({required this.courts, super.key});

  final List<StaffEntity> courts;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeader(title: AppLocalizations.of(context)!.homeCourts),
      const SizedBox(height: HomeDimensions.smallSpacing),
      SizedBox(
        height: HomeDimensions.courtRowHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: courts.length,
          separatorBuilder: (context, index) =>
              const SizedBox(width: HomeDimensions.itemSpacing),
          itemBuilder: (context, index) => CourtAvatar(court: courts[index]),
        ),
      ),
    ],
  );
}
