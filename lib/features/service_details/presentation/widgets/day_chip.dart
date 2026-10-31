import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_curves.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../domain/entities/availability_day_entity.dart';
import 'service_details_dimensions.dart';

final class DayChip extends StatelessWidget {
  const DayChip({
    required this.day,
    required this.locale,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final AvailabilityDayEntity day;
  final String locale;
  final bool selected;
  final ValueChanged<String>? onSelected;

  bool get _enabled => day.open && day.slotsCount > 0;

  @override
  Widget build(BuildContext context) {
    final date = _dateOnly(day.date);
    final weekday = date == null
        ? day.day
        : DateFormat.E(locale).format(date);
    final dayNumber = day.date.split('-').last;
    return Semantics(
      button: true,
      enabled: _enabled,
      selected: selected,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: _enabled
              ? () {
                  HapticFeedback.selectionClick();
                  onSelected?.call(day.date);
                }
              : null,
          child: AnimatedContainer(
            duration: ServiceDetailsDimensions.galleryIndicatorDuration,
            curve: AppCurves.standard,
            width: ServiceDetailsDimensions.dayChipWidth,
            height: ServiceDetailsDimensions.dayChipHeight,
            padding: const EdgeInsetsDirectional.all(
              ServiceDetailsDimensions.smallSpacing,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : _enabled
                  ? AppColors.surface
                  : AppColors.surfaceMuted,
              border: Border.all(
                color: selected
                    ? AppColors.primary
                    : _enabled
                    ? AppColors.border
                    : AppColors.surfaceMuted,
              ),
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: selected ? AppShadows.card : const [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weekday,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _textColor,
                  ),
                ),
                Text(
                  dayNumber,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _textColor {
    if (!_enabled) return AppColors.textDisabled;
    return selected ? AppColors.onPrimary : AppColors.textPrimary;
  }

  DateTime? _dateOnly(String value) {
    final parts = value.split('-');
    if (parts.length != ServiceDetailsDimensions.datePartsCount) return null;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final dayOfMonth = int.tryParse(parts[2]);
    if (year == null || month == null || dayOfMonth == null) return null;
    return DateTime.utc(year, month, dayOfMonth);
  }
}
