import 'package:flutter/material.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../domain/entities/availability_day_entity.dart';
import '../cubit/service_details_state.dart';
import 'day_chip.dart';
import 'service_details_dimensions.dart';

final class DaysStrip extends StatelessWidget {
  const DaysStrip({
    required this.days,
    required this.status,
    required this.failure,
    required this.selectedDate,
    required this.onSelected,
    required this.onRetry,
    super.key,
  });

  final List<AvailabilityDayEntity> days;
  final ServiceDetailsLoadStatus status;
  final Failure? failure;
  final String? selectedDate;
  final ValueChanged<String> onSelected;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.serviceChooseTime, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: ServiceDetailsDimensions.smallSpacing),
        if (status == ServiceDetailsLoadStatus.loading ||
            status == ServiceDetailsLoadStatus.initial)
          const LinearProgressIndicator(
            color: AppColors.primary,
            minHeight: ServiceDetailsDimensions.dividerThickness,
          )
        else if (status == ServiceDetailsLoadStatus.failure)
          SizedBox(
            height: ServiceDetailsDimensions.failedContentHeight,
            child: AppErrorView(
              message: failure!.localized(l10n),
              onRetry: onRetry,
            ),
          )
        else if (days.isEmpty)
          AppEmptyView(message: l10n.serviceNoSlots)
        else
          SizedBox(
            height: ServiceDetailsDimensions.dayChipHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              separatorBuilder: (context, index) => const SizedBox(
                width: ServiceDetailsDimensions.smallSpacing,
              ),
              itemBuilder: (context, index) => DayChip(
                day: days[index],
                locale: locale,
                selected: days[index].date == selectedDate,
                onSelected: onSelected,
              ),
            ),
          ),
      ],
    );
  }
}
