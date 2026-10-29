import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/widgets/app_error_view.dart';
import 'package:kora/core/widgets/app_loader.dart';
import 'package:kora/features/home/domain/entities/rating_entity.dart';
import 'package:kora/features/home/domain/entities/service_attributes_entity.dart';
import 'package:kora/features/home/domain/entities/service_category_ref_entity.dart';
import 'package:kora/features/home/domain/entities/service_entity.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_state.dart';
import 'package:kora/features/service_details/presentation/widgets/service_details_view.dart';

void main() {
  testWidgets('shows an inline loader while details are loading', (
    tester,
  ) async {
    await _pumpView(
      tester,
      const ServiceDetailsState(
        detailsStatus: ServiceDetailsLoadStatus.loading,
      ),
    );

    expect(find.byType(AppLoader), findsOneWidget);
  });

  testWidgets('shows details failure and exposes a retry callback', (
    tester,
  ) async {
    var retried = false;
    await _pumpView(
      tester,
      const ServiceDetailsState(
        detailsStatus: ServiceDetailsLoadStatus.failure,
        detailsFailure: NetworkFailure(),
      ),
      onRetry: () => retried = true,
    );

    expect(find.byType(AppErrorView), findsOneWidget);
    final context = tester.element(find.byType(AppErrorView));
    expect(
      find.text(AppLocalizations.of(context)!.errorNetwork),
      findsOneWidget,
    );
    tester
        .widget<ElevatedButton>(
          find.descendant(
            of: find.byType(AppErrorView),
            matching: find.byType(ElevatedButton),
          ),
        )
        .onPressed!
        .call();
    expect(retried, isTrue);
  });

  testWidgets('renders service information when details are loaded', (
    tester,
  ) async {
    const service = ServiceEntity(
      id: 82,
      name: 'Service name',
      slug: 'service',
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
      category: ServiceCategoryRefEntity(id: 1, name: 'Category', icon: ''),
      staff: [],
      isFeatured: false,
    );
    const details = ServiceDetailsEntity(
      service: service,
      rating: RatingEntity(average: 0, count: 0),
      related: [],
    );
    await tester.binding.setSurfaceSize(const Size(400, 1000));
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: ServiceDetailsView(
            state: ServiceDetailsState(
              serviceId: details.service.id,
              detailsStatus: ServiceDetailsLoadStatus.loaded,
              daysStatus: ServiceDetailsLoadStatus.loaded,
              slotsStatus: ServiceDetailsLoadStatus.loaded,
              details: details,
            ),
            initialService: null,
            currencySymbol: '₪',
            onRetryDetails: _ignore,
            onSelectStaff: _ignoreStaff,
            onSelectDate: _ignoreDate,
            onSelectSlot: _ignoreSlot,
            onRetryDays: _ignore,
            onRetrySlots: _ignore,
          ),
        ),
      ),
    );

    expect(find.text(service.name), findsOneWidget);
    expect(find.text(service.category.name), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.binding.setSurfaceSize(null);
  });
}

Future<void> _pumpView(
  WidgetTester tester,
  ServiceDetailsState state, {
  VoidCallback onRetry = _ignore,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: ServiceDetailsView(
          state: state,
          initialService: null,
          currencySymbol: '₪',
          onRetryDetails: onRetry,
          onSelectStaff: _ignoreStaff,
          onSelectDate: _ignoreDate,
          onSelectSlot: _ignoreSlot,
          onRetryDays: _ignore,
          onRetrySlots: _ignore,
        ),
      ),
    ),
  );
}

void _ignore() {}

void _ignoreStaff(int? staffId) {}

void _ignoreDate(String date) {}

void _ignoreSlot(TimeSlotEntity slot) {}
