import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kora/core/l10n/generated/app_localizations.dart';
import 'package:kora/core/error/failure.dart';
import 'package:kora/core/error/result.dart';
import 'package:kora/core/widgets/app_empty_view.dart';
import 'package:kora/core/widgets/app_error_view.dart';
import 'package:kora/core/widgets/app_loader.dart';
import 'package:kora/features/services/domain/entities/services_page_entity.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';
import 'package:kora/features/services/domain/repositories/services_repository.dart';
import 'package:kora/features/services/domain/usecases/get_services_use_case.dart';
import 'package:kora/features/home/domain/entities/attribute_display_entity.dart';
import 'package:kora/features/home/domain/entities/service_attributes_entity.dart';
import 'package:kora/features/home/domain/entities/service_category_ref_entity.dart';
import 'package:kora/features/home/domain/entities/service_entity.dart';
import 'package:kora/features/services/presentation/cubit/services_cubit.dart';
import 'package:kora/features/services/presentation/pages/services_page_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

class _ServicesRepositoryMock extends Mock implements ServicesRepository {}

void main() {
  late _ServicesRepositoryMock repository;

  setUpAll(() {
    registerFallbackValue(const ServicesQuery());
  });

  setUp(() {
    repository = _ServicesRepositoryMock();
  });

  testWidgets('shows inline loader while loading', (tester) async {
    final completer = Completer<Result<ServicesPageEntity>>();
    when(
      () => repository.getServices(any()),
    ).thenAnswer((_) => completer.future);
    final cubit = ServicesCubit(GetServicesUseCase(repository));
    final request = cubit.init();
    await pumpApp(
      tester,
      BlocProvider.value(
        value: cubit,
        child: const ServicesPageView(
          categories: [],
          autofocusSearch: false,
          currencySymbol: '',
        ),
      ),
    );

    expect(find.byType(AppLoader), findsOneWidget);
    completer.complete(
      const Success(
        ServicesPageEntity(
          items: [],
          page: 1,
          perPage: ServicesQuery.defaultPerPage,
          total: 0,
          lastPage: 1,
        ),
      ),
    );
    await request;
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });

  testWidgets('shows localized empty results', (tester) async {
    when(() => repository.getServices(any())).thenAnswer(
      (_) async => const Success(
        ServicesPageEntity(
          items: [],
          page: 1,
          perPage: ServicesQuery.defaultPerPage,
          total: 0,
          lastPage: 1,
        ),
      ),
    );
    final cubit = ServicesCubit(GetServicesUseCase(repository));
    await cubit.init();
    await pumpApp(
      tester,
      BlocProvider.value(
        value: cubit,
        child: const ServicesPageView(
          categories: [],
          autofocusSearch: false,
          currencySymbol: '',
        ),
      ),
    );

    expect(find.byType(AppEmptyView), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });

  testWidgets('shows failure and retries on tap', (tester) async {
    when(
      () => repository.getServices(any()),
    ).thenAnswer((_) async => const Failed(NetworkFailure()));
    final cubit = ServicesCubit(GetServicesUseCase(repository));
    await cubit.init();
    await pumpApp(
      tester,
      BlocProvider.value(
        value: cubit,
        child: const ServicesPageView(
          categories: [],
          autofocusSearch: false,
          currencySymbol: '',
        ),
      ),
    );

    expect(find.byType(AppErrorView), findsOneWidget);
    final context = tester.element(find.byType(AppErrorView));
    await tester.tap(find.text(AppLocalizations.of(context)!.retry));
    await tester.pumpAndSettle();

    verify(() => repository.getServices(any())).called(2);
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });

  testWidgets('renders loaded service data', (tester) async {
    const service = ServiceEntity(
      id: 75,
      name: 'Fixture service',
      slug: 'fixture-service',
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
      attributesDisplay: <AttributeDisplayEntity>[],
      category: ServiceCategoryRefEntity(id: 1, name: '', icon: ''),
      staff: [],
      isFeatured: false,
    );
    const page = ServicesPageEntity(
      items: [service],
      page: 1,
      perPage: ServicesQuery.defaultPerPage,
      total: 1,
      lastPage: 1,
    );
    when(
      () => repository.getServices(any()),
    ).thenAnswer((_) async => Success(page));
    final cubit = ServicesCubit(GetServicesUseCase(repository));
    await cubit.init();
    await pumpApp(
      tester,
      BlocProvider.value(
        value: cubit,
        child: const ServicesPageView(
          categories: [],
          autofocusSearch: false,
          currencySymbol: '₪',
        ),
      ),
    );

    expect(find.text(service.name), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });
}
