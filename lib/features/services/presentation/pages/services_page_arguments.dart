import '../../../home/domain/entities/category_entity.dart';

final class ServicesPageArguments {
  const ServicesPageArguments({
    this.categories = const [],
    this.initialCategoryId,
    this.autofocusSearch = false,
    this.currencySymbol = '',
  });

  final List<CategoryEntity> categories;
  final int? initialCategoryId;
  final bool autofocusSearch;
  final String currencySymbol;
}
