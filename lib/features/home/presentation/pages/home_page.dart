import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/service_entity.dart';
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
            onBook: _onBook,
            onServiceTap: _onServiceTap,
          ),
        ),
      ),
    ),
  );

  void _onBook(ServiceEntity service) {}

  void _onServiceTap(ServiceEntity service) {}
}
