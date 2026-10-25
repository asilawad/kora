import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/home/data/models/home_data_model.dart';

import '../../helpers/load_home_model.dart';

void main() {
  late HomeDataModel home;

  setUpAll(() async {
    home = await loadHomeModel();
  });

  test('parses place details, booking rules, and intake fields', () {
    expect(home.place.name, 'Kora');
    expect(home.place.currencySymbol, '₪');
    expect(home.place.bookingRules.windowDays, 30);
    expect(home.place.bookingRules.minNoticeMinutes, 60);
    expect(home.place.bookingRules.cancelBeforeHours, 2);
    expect(home.place.bookingRules.maxActiveBookings, 3);
    expect(home.place.bookingRules.autoConfirm, isTrue);
    expect(home.place.intakeFields, hasLength(2));
    expect(home.place.intakeFields.last.unit, 'لاعب');
  });

  test('parses expected home collection sizes', () {
    expect(home.categories, hasLength(8));
    expect(home.featured, hasLength(6));
    expect(home.popular, hasLength(10));
    expect(home.staff, hasLength(4));
  });

  test('parses service 77 sale price and discount', () {
    final service = home.featured.firstWhere((service) => service.id == 77);

    expect(service.salePrice, 119.99);
    expect(service.discountPercent, 25);
  });

  test('parses service 74 with whole price and no sale price', () {
    final service = home.popular.firstWhere((service) => service.id == 74);

    expect(service.price, 120);
    expect(service.salePrice, isNull);
  });

  test('parses service 75 as a group with no assigned staff', () {
    final service = home.popular.firstWhere((service) => service.id == 75);

    expect(service.staff, isEmpty);
    expect(service.capacity, 12);
    expect(service.isGroup, isTrue);
  });
}
