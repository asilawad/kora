import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_curves.dart';
import '../../../../core/theme/app_durations.dart';
import 'home_dimensions.dart';

final class HomeSectionEntrance extends StatefulWidget {
  const HomeSectionEntrance({
    required this.child,
    required this.delay,
    super.key,
  });

  final Widget child;
  final Duration delay;

  @override
  State<HomeSectionEntrance> createState() => _HomeSectionEntranceState();
}

final class _HomeSectionEntranceState extends State<HomeSectionEntrance> {
  Timer? _timer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void didUpdateWidget(covariant HomeSectionEntrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.delay != widget.delay && !_visible) {
      _timer?.cancel();
      _timer = Timer(widget.delay, () {
        if (mounted) setState(() => _visible = true);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: _visible
        ? HomeDimensions.sectionAnimationEnd
        : HomeDimensions.sectionAnimationHidden,
    duration: AppDurations.normal,
    curve: AppCurves.standard,
    child: AnimatedSlide(
      offset: Offset(
        0,
        _visible
            ? HomeDimensions.sectionAnimationHidden
            : HomeDimensions.sectionAnimationSlide,
      ),
      duration: AppDurations.normal,
      curve: AppCurves.standard,
      child: widget.child,
    ),
  );
}
