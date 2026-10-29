import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_routes.dart';
import '../../../app_shell/presentation/app_shell_navigation.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_dimensions.dart';
import '../widgets/home_state_view.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppShellNavigation.homeScrollRequests.addListener(_scrollToTop);
  }

  @override
  void dispose() {
    AppShellNavigation.homeScrollRequests.removeListener(_scrollToTop);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      0,
      duration: HomeDimensions.scrollToTopDuration,
      curve: Curves.easeOut,
    );
  }

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
            scrollController: _scrollController,
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
