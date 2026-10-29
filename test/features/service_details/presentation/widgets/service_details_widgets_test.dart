import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/widgets/primary_button.dart';
import 'package:kora/features/home/domain/entities/service_attributes_entity.dart';
import 'package:kora/features/home/domain/entities/service_category_ref_entity.dart';
import 'package:kora/features/home/domain/entities/service_entity.dart';
import 'package:kora/features/home/domain/entities/staff_ref_entity.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/staff_ref_lite_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_state.dart';
import 'package:kora/features/service_details/presentation/widgets/court_selector.dart';
import 'package:kora/features/service_details/presentation/widgets/day_chip.dart';
import 'package:kora/features/service_details/presentation/widgets/service_details_dimensions.dart';
import 'package:kora/features/service_details/presentation/widgets/slots_section.dart';
import 'package:kora/features/service_details/presentation/widgets/sticky_book_bar.dart';

import '../../../../helpers/pump_app.dart';

const _emptyService = ServiceEntity(
  id: 75,
  name: 'Court service',
  slug: 'court-service',
  durationMinutes: 60,
  durationLabel: '60 min',
  price: 50,
  finalPrice: 50,
  capacity: 1,
  isGroup: false,
  image: '',
  thumb: '',
  images: [],
  attributes: ServiceAttributesEntity(),
  attributesDisplay: [],
  category: ServiceCategoryRefEntity(id: 1, name: '', icon: ''),
  staff: [],
  isFeatured: false,
);

void main() {
  testWidgets('selects a court and hides the selector when staff is empty', (tester) async {
    final service = _serviceWithStaff();
    int? selected;
    await pumpApp(
      tester,
      CourtSelector(
        service: service,
        selectedStaffId: null,
        onSelected: (id) => selected = id,
      ),
    );

    expect(find.text('ملعب الزيتون'), findsOneWidget);
    await tester.tap(find.text('ملعب الزيتون'));
    expect(selected, service.staff.first.id);

    await pumpApp(
      tester,
      const CourtSelector(
        service: _emptyService,
        selectedStaffId: null,
        onSelected: _ignoreStaff,
      ),
    );
    expect(find.byType(CourtSelector), findsOneWidget);
    final emptyContext = tester.element(find.byType(CourtSelector));
    expect(
      find.text(AppLocalizations.of(emptyContext)!.serviceWith),
      findsNothing,
    );
  });

  testWidgets('groups slots by period and returns the selected slot', (tester) async {
    final morning = _slot('11:45');
    final noon = _slot('12:00');
    final evening = _slot('17:00');
    TimeSlotEntity? selected;
    await pumpApp(
      tester,
      SlotsSection(
        slots: [morning, noon, evening],
        status: ServiceDetailsLoadStatus.loaded,
        failure: null,
        selectedSlot: null,
        isGroup: false,
        onSelected: (slot) => selected = slot,
        onRetry: _ignore,
      ),
    );

    final context = tester.element(find.byType(SlotsSection));
    final l10n = AppLocalizations.of(context)!;
    expect(find.text(l10n.periodMorning), findsOneWidget);
    expect(find.text(l10n.periodAfternoon), findsOneWidget);
    expect(find.text(l10n.periodEvening), findsOneWidget);
    await tester.tap(find.text('12:00'));
    expect(selected, noon);
  });

  testWidgets('booking button requires a selected slot', (tester) async {
    await pumpApp(
      tester,
      const StickyBookBar(
        service: _emptyService,
        currencySymbol: '₪',
        slot: null,
        onBook: null,
      ),
    );
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);

    final slot = _slot('12:00');
    TimeSlotEntity? booked;
    await pumpApp(
      tester,
      StickyBookBar(
        service: _emptyService,
        currencySymbol: '₪',
        slot: slot,
        onBook: (value) => booked = value,
      ),
    );
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNotNull,
    );
    await tester.tap(find.byType(PrimaryButton));
    expect(booked, slot);
  });

  testWidgets('DayChip is disabled for closed days', (tester) async {
    var selected = false;
    await pumpApp(
      tester,
      DayChip(
        day: const AvailabilityDayEntity(
          date: '2026-10-30',
          day: 'Friday',
          label: 'Closed',
          open: false,
          slotsCount: 0,
        ),
        locale: 'ar',
        selected: false,
        onSelected: (_) => selected = true,
      ),
    );

    expect(
      tester.getSize(find.byType(DayChip)).width,
      ServiceDetailsDimensions.dayChipWidth,
    );
    await tester.tap(find.byType(DayChip));
    expect(selected, isFalse);
  });
}

ServiceEntity _serviceWithStaff() => const ServiceEntity(
  id: 82,
  name: 'Staff service',
  slug: 'staff-service',
  durationMinutes: 60,
  durationLabel: '60 min',
  price: 50,
  finalPrice: 50,
  capacity: 1,
  isGroup: false,
  image: '',
  thumb: '',
  images: [],
  attributes: ServiceAttributesEntity(),
  attributesDisplay: [],
  category: ServiceCategoryRefEntity(id: 1, name: '', icon: ''),
  staff: [
    StaffRefEntity(
      id: 55,
      name: 'ملعب الزيتون',
      title: '',
      avatar: '',
      initials: '',
      color: '#0EA5A4',
    ),
  ],
  isFeatured: false,
);

TimeSlotEntity _slot(String time) => TimeSlotEntity(
  time: time,
  startsAt: time,
  endsAt: time,
  staff: const [StaffRefLiteEntity(id: 55, name: 'Court')],
  seatsLeft: 3,
);

void _ignore() {}

void _ignoreStaff(int? staffId) {}
