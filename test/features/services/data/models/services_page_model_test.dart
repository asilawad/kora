import 'package:flutter_test/flutter_test.dart';

import '../../helpers/load_services_page.dart';

void main() {
  test('parses the real services page fixture and metadata', () async {
    final page = await loadServicesPage();

    expect(page.items, hasLength(10));
    expect(page.page, 1);
    expect(page.perPage, 15);
    expect(page.total, 10);
    expect(page.lastPage, 1);
    expect(page.hasMore, isFalse);
  });

  test('parses the real empty services fixture', () async {
    final page = await loadServicesPage(
      fixture: 'services_empty_response.json',
    );

    expect(page.items, isEmpty);
    expect(page.total, 0);
    expect(page.hasMore, isFalse);
  });
}
