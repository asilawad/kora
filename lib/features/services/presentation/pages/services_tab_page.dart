import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/error/result.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../home/domain/entities/category_entity.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/domain/usecases/get_home_use_case.dart';
import 'services_page.dart';

/// Services as a bottom-navigation tab. Categories and currency come from the
/// same home request used by the Home tab (no extra endpoint).
final class ServicesTabPage extends StatefulWidget {
  const ServicesTabPage({super.key});

  @override
  State<ServicesTabPage> createState() => _ServicesTabPageState();
}

final class _ServicesTabPageState extends State<ServicesTabPage> {
  late final Future<Result<HomeDataEntity>> _home = sl<GetHomeUseCase>()();

  @override
  Widget build(BuildContext context) => FutureBuilder<Result<HomeDataEntity>>(
    future: _home,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Scaffold(body: AppLoader());
      }
      final result = snapshot.data;
      var categories = const <CategoryEntity>[];
      var currency = '';
      if (result is Success<HomeDataEntity>) {
        categories = result.data.categories;
        currency = result.data.place.currencySymbol;
      }
      return ServicesPage(
        categories: categories,
        currencySymbol: currency,
        showBack: false,
      );
    },
  );
}
