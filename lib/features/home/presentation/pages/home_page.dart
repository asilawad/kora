import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_state_view.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => sl<HomeCubit>()..load(),
    child: Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => HomeStateView(
            state: state,
            onLoad: context.read<HomeCubit>().load,
            onRefresh: context.read<HomeCubit>().refresh,
            onCategorySelected: context.read<HomeCubit>().selectCategory,
            onBook: (service) => context.pushNamed(
              AppRoutes.serviceDetailsName,
              pathParameters: {
                AppRoutes.serviceIdParameter: service.id.toString(),
              },
              extra: service,
            ),
            onServiceTap: (service) => context.pushNamed(
              AppRoutes.serviceDetailsName,
              pathParameters: {
                AppRoutes.serviceIdParameter: service.id.toString(),
              },
              extra: service,
            ),
          ),
        ),
      ),
    ),
  );
}
