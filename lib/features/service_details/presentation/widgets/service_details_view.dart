import 'package:flutter/material.dart';

import '../../../../core/error/failure_message.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../home/domain/entities/service_entity.dart';
import '../../domain/entities/time_slot_entity.dart';
import '../cubit/service_details_state.dart';
import 'attributes_section.dart';
import 'court_selector.dart';
import 'days_strip.dart';
import 'description_section.dart';
import 'related_services_list.dart';
import 'service_details_dimensions.dart';
import 'service_gallery.dart';
import 'service_info_header.dart';
import 'slots_section.dart';

final class ServiceDetailsView extends StatelessWidget {
  const ServiceDetailsView({
    required this.state,
    required this.initialService,
    required this.currencySymbol,
    required this.onRetryDetails,
    required this.onSelectStaff,
    required this.onSelectDate,
    required this.onSelectSlot,
    required this.onRetryDays,
    required this.onRetrySlots,
    super.key,
  });

  final ServiceDetailsState state;
  final ServiceEntity? initialService;
  final String currencySymbol;
  final VoidCallback onRetryDetails;
  final ValueChanged<int?> onSelectStaff;
  final ValueChanged<String> onSelectDate;
  final ValueChanged<TimeSlotEntity> onSelectSlot;
  final VoidCallback onRetryDays;
  final VoidCallback onRetrySlots;

  @override
  Widget build(BuildContext context) {
    final service = state.service ?? initialService;
    final l10n = AppLocalizations.of(context)!;
    final hasDescription =
        service?.description?.trim().isNotEmpty ?? false;
    if (service == null &&
        state.detailsStatus == ServiceDetailsLoadStatus.loading) {
      return const AppLoader();
    }
    if (service == null &&
        state.detailsStatus == ServiceDetailsLoadStatus.failure) {
      return AppErrorView(
        message: state.detailsFailure!.localized(l10n),
        onRetry: onRetryDetails,
      );
    }
    final details = state.details;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.only(
            bottom: ServiceDetailsDimensions.sectionSpacing,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              ServiceGallery(service: service!),
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  ServiceDetailsDimensions.pagePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceInfoHeader(
                      service: service,
                      currencySymbol: currencySymbol,
                      rating: details?.rating,
                    ),
                    const SizedBox(
                      height: ServiceDetailsDimensions.sectionSpacing,
                    ),
                    if (state.detailsStatus == ServiceDetailsLoadStatus.loading)
                      const SizedBox(
                        height: ServiceDetailsDimensions.failedContentHeight,
                        child: AppLoader(),
                      )
                    else if (state.detailsStatus ==
                        ServiceDetailsLoadStatus.failure)
                      SizedBox(
                        height: ServiceDetailsDimensions.failedContentHeight,
                        child: AppErrorView(
                          message: state.detailsFailure!.localized(l10n),
                          onRetry: onRetryDetails,
                        ),
                      )
                    else if (details != null) ...[
                      CourtSelector(
                        service: service,
                        selectedStaffId: state.selectedStaffId,
                        onSelected: onSelectStaff,
                      ),
                      if (service.staff.isNotEmpty)
                        const SizedBox(
                          height: ServiceDetailsDimensions.sectionSpacing,
                        ),
                      DaysStrip(
                        days: state.days,
                        status: state.daysStatus,
                        failure: state.daysFailure,
                        selectedDate: state.selectedDate,
                        onSelected: onSelectDate,
                        onRetry: onRetryDays,
                      ),
                      const SizedBox(
                        height: ServiceDetailsDimensions.itemSpacing,
                      ),
                      SlotsSection(
                        slots: state.slots,
                        status: state.slotsStatus,
                        failure: state.slotsFailure,
                        selectedSlot: state.selectedSlot,
                        isGroup: service.isGroup,
                        onSelected: onSelectSlot,
                        onRetry: onRetrySlots,
                      ),
                      const SizedBox(
                        height: ServiceDetailsDimensions.sectionSpacing,
                      ),
                      AttributesSection(
                        attributes: service.attributesDisplay,
                      ),
                      if (service.attributesDisplay.isNotEmpty &&
                          hasDescription)
                        const SizedBox(
                          height: ServiceDetailsDimensions.sectionSpacing,
                        ),
                      DescriptionSection(description: service.description),
                      if ((service.attributesDisplay.isNotEmpty ||
                              hasDescription) &&
                          details.related.isNotEmpty)
                        const SizedBox(
                          height: ServiceDetailsDimensions.sectionSpacing,
                        ),
                      RelatedServicesList(
                        services: details.related,
                        currencySymbol: currencySymbol,
                      ),
                    ],
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
