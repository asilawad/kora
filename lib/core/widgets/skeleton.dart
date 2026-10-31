import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_durations.dart';
import 'widget_dimensions.dart';

final class Skeleton extends StatefulWidget {
  const Skeleton({required this.child, super.key});

  final Widget child;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

final class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.slow,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    child: widget.child,
    builder: (context, child) => ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment(-WidgetDimensions.shimmerTravel + _controller.value, 0),
        end: Alignment(WidgetDimensions.shimmerTravel + _controller.value, 0),
        colors: const [
          AppColors.surfaceMuted,
          AppColors.surface,
          AppColors.surfaceMuted,
        ],
        stops: const [
          WidgetDimensions.shimmerStart,
          WidgetDimensions.shimmerMiddle,
          WidgetDimensions.shimmerEnd,
        ],
      ).createShader(bounds),
      child: child,
    ),
  );
}
