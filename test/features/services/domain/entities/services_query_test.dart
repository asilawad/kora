import 'package:flutter_test/flutter_test.dart';
import 'package:kora/features/services/domain/entities/service_sort.dart';
import 'package:kora/features/services/domain/entities/services_query.dart';

void main() {
  test('maps every sort to the API sort and order parameters', () {
    expect(ServiceSort.popular.apiValue, 'popular');
    expect(ServiceSort.popular.apiOrder, isNull);
    expect(ServiceSort.priceAsc.apiValue, 'price');
    expect(ServiceSort.priceAsc.apiOrder, 'asc');
    expect(ServiceSort.priceDesc.apiValue, 'price');
    expect(ServiceSort.priceDesc.apiOrder, 'desc');
    expect(ServiceSort.durationAsc.apiValue, 'duration');
    expect(ServiceSort.durationAsc.apiOrder, 'asc');
    expect(ServiceSort.nameAsc.apiValue, 'name');
    expect(ServiceSort.nameAsc.apiOrder, 'asc');
  });

  test('query copy, equality, hashCode and defaults', () {
    const original = ServicesQuery();
    final filtered = original.copyWith(search: 'tennis', categoryId: 3);

    expect(original.perPage, ServicesQuery.defaultPerPage);
    expect(filtered.search, 'tennis');
    expect(filtered.categoryId, 3);
    expect(filtered.copyWith(clearCategory: true).categoryId, isNull);
    expect(filtered, ServicesQuery(search: 'tennis', categoryId: 3));
    expect(filtered.hashCode, ServicesQuery(search: 'tennis', categoryId: 3).hashCode);
  });
}
