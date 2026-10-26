enum ServiceSort {
  popular('popular', null),
  priceAsc('price', 'asc'),
  priceDesc('price', 'desc'),
  durationAsc('duration', 'asc'),
  nameAsc('name', 'asc');

  const ServiceSort(this.apiValue, this.apiOrder);

  final String apiValue;
  final String? apiOrder;
}
