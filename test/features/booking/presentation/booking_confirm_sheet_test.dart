import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/constants/api_constants.dart';
import 'package:kora/core/di/injection.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/features/booking/data/models/booking_model.dart';
import 'package:kora/features/booking/domain/entities/booking_entity.dart';
import 'package:kora/features/booking/domain/entities/create_booking_params.dart';
import 'package:kora/features/booking/domain/repositories/booking_repository.dart';
import 'package:kora/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:kora/features/booking/presentation/booking_confirm_sheet.dart';
import 'package:kora/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';
import 'package:kora/features/home/domain/providers/place_info_provider.dart';
import 'package:kora/features/service_details/domain/entities/time_slot_entity.dart';
import 'package:kora/features/service_details/domain/entities/availability_day_entity.dart';
import 'package:kora/features/service_details/domain/entities/service_details_entity.dart';
import 'package:kora/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:kora/features/service_details/domain/usecases/get_availability_days_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_service_details_use_case.dart';
import 'package:kora/features/service_details/domain/usecases/get_time_slots_use_case.dart';
import 'package:kora/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookingRepository extends Mock implements BookingRepository {}

final class _FakeServiceDetailsRepository implements ServiceDetailsRepository {
  final List<String> requestedDates = [];

  @override
  Future<Result<ServiceDetailsEntity>> getDetails(int serviceId) async =>
      const Failed(UnknownFailure());

  @override
  Future<Result<List<AvailabilityDayEntity>>> getDays(
    int serviceId, {
    required int days,
    int? staffId,
  }) async => const Success([]);

  @override
  Future<Result<List<TimeSlotEntity>>> getSlots(
    int serviceId, {
    required String date,
    int? staffId,
  }) async {
    requestedDates.add(date);
    return const Success([]);
  }
}

Map<String, dynamic> _fixture(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  late _MockBookingRepository repository;
  late _FakeServiceDetailsRepository detailsRepository;
  late ServiceDetailsCubit detailsCubit;
  late HomeDataModel home;
  late TimeSlotEntity slot;
  Future<BookingEntity?>? sheetResult;

  setUpAll(() {
    registerFallbackValue(
      const CreateBookingParams(serviceId: 1, startsAt: '', answers: {}),
    );
  });

  setUp(() async {
    home = HomeDataModel.fromJson(
      _fixture('test/fixtures/home_response.json')[ApiResponseKeys.data],
    );
    repository = _MockBookingRepository();
    detailsRepository = _FakeServiceDetailsRepository();
    detailsCubit = ServiceDetailsCubit(
      getDetails: GetServiceDetailsUseCase(detailsRepository),
      getDays: GetAvailabilityDaysUseCase(detailsRepository),
      getSlots: GetTimeSlotsUseCase(detailsRepository),
    );
    await detailsCubit.load(74);
    slot = const TimeSlotEntity(
      time: '10:00',
      startsAt: '2026-10-31T10:00:00+02:00',
      endsAt: '2026-10-31T11:00:00+02:00',
      staff: [],
      seatsLeft: 1,
    );
    sl.registerSingleton<PlaceInfoProvider>(
      PlaceInfoProvider()..update(home.place),
    );
    sl.registerFactory<BookingCubit>(
      () => BookingCubit(CreateBookingUseCase(repository)),
    );
    sheetResult = null;
  });

  tearDown(() async {
    await detailsCubit.close();
    await sl.reset();
  });

  Future<void> openSheet(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<ServiceDetailsCubit>.value(
          value: detailsCubit,
          child: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    sheetResult = BookingConfirmSheet.show(
                      context,
                      service: home.featured.first,
                      date: '2026-10-31',
                      dayLabel: 'السبت',
                      slot: slot,
                      staffId: 55,
                      detailsCubit: detailsCubit,
                    );
                  },
                  child: const Text('Open sheet'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();
  }

  testWidgets('keeps the sheet open and shows a server failure', (tester) async {
    when(() => repository.create(any())).thenAnswer(
      (_) async => const Failed(
        ValidationFailure(
          message: 'لديك حجز آخر في نفس الوقت',
          code: ApiErrorCodes.customerOverlap,
        ),
      ),
    );
    await openSheet(tester);

    await tester.tap(find.text('Confirm booking').last);
    await tester.pumpAndSettle();

    expect(find.text('لديك حجز آخر في نفس الوقت'), findsOneWidget);
    expect(find.text('Confirm booking'), findsNWidgets(2));
    expect(detailsRepository.requestedDates, isEmpty);
  });

  testWidgets('reloads the selected date after a slot-unavailable failure', (
    tester,
  ) async {
    when(() => repository.create(any())).thenAnswer(
      (_) async => const Failed(
        SlotUnavailableFailure(
          message: 'هذا الموعد لم يعد متاحًا',
          code: ApiErrorCodes.slotUnavailable,
        ),
      ),
    );
    await openSheet(tester);

    await tester.tap(find.text('Confirm booking').last);
    await tester.pumpAndSettle();

    expect(find.text('هذا الموعد لم يعد متاحًا'), findsOneWidget);
    expect(detailsRepository.requestedDates, ['2026-10-31']);
  });

  testWidgets('closes and returns the created booking on success', (tester) async {
    final booking = BookingModel.fromJson(
      _fixture('test/fixtures/booking_create_success_response.json')['data'],
    );
    when(
      () => repository.create(any()),
    ).thenAnswer((_) async => Success(booking));
    await openSheet(tester);

    await tester.tap(find.text('Confirm booking').last);
    await tester.pumpAndSettle();

    expect(await sheetResult, booking);
    expect(find.text('Confirm booking'), findsNothing);
  });
}
