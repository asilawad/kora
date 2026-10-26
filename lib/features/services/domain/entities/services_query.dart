import 'service_sort.dart';

final class ServicesQuery {
  static const int defaultPerPage = 15;

  const ServicesQuery({
    this.search = '',
    this.categoryId,
    this.sort = ServiceSort.popular,
    this.page = 1,
    this.perPage = defaultPerPage,
  });

  final String search;
  final int? categoryId;
  final ServiceSort sort;
  final int page;
  final int perPage;

  ServicesQuery copyWith({
    String? search,
    int? categoryId,
    bool clearCategory = false,
    ServiceSort? sort,
    int? page,
    int? perPage,
  }) => ServicesQuery(
    search: search ?? this.search,
    categoryId: clearCategory ? null : categoryId ?? this.categoryId,
    sort: sort ?? this.sort,
    page: page ?? this.page,
    perPage: perPage ?? this.perPage,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesQuery &&
          search == other.search &&
          categoryId == other.categoryId &&
          sort == other.sort &&
          page == other.page &&
          perPage == other.perPage;

  @override
  int get hashCode => Object.hash(search, categoryId, sort, page, perPage);
}
