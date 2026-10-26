import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../home/domain/entities/category_entity.dart';
import '../cubit/services_cubit.dart';
import 'services_page_view.dart';

final class ServicesPage extends StatelessWidget {
  const ServicesPage({
    required this.categories,
    this.initialCategoryId,
    this.autofocusSearch = false,
    this.currencySymbol = '',
    super.key,
  });

  final List<CategoryEntity> categories;
  final int? initialCategoryId;
  final bool autofocusSearch;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => sl<ServicesCubit>()
      ..init(categoryId: initialCategoryId),
    child: ServicesPageView(
      categories: categories,
      autofocusSearch: autofocusSearch,
      currencySymbol: currencySymbol,
    ),
  );
}
