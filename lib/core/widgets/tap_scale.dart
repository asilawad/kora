import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_curves.dart';
import '../theme/app_durations.dart';
import 'widget_dimensions.dart';

final class TapScale extends StatefulWidget {
  const TapScale({
    required this.child,
    this.onTap,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  State<TapScale> createState() => _TapScaleState();
}

final class _TapScaleState extends State<TapScale> {
  bool _pressed = false;
  Offset? _pointerDown;

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: widget.enabled ? _onPointerDown : null,
    onPointerUp: widget.enabled ? _onPointerUp : null,
    onPointerCancel: (_) => _setPressed(false),
    child: GestureDetector(
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _pressed
            ? WidgetDimensions.tapScalePressed
            : WidgetDimensions.tapScaleDefault,
        duration: AppDurations.fast,
        curve: AppCurves.standard,
        child: widget.child,
      ),
    ),
  );

  void _onPointerDown(PointerDownEvent event) {
    _pointerDown = event.position;
    _setPressed(true);
  }

  void _onPointerUp(PointerUpEvent event) {
    final start = _pointerDown;
    if (start != null &&
        (event.position - start).distance <=
            WidgetDimensions.tapMovementTolerance) {
      HapticFeedback.selectionClick();
    }
    _pointerDown = null;
    _setPressed(false);
  }

  void _setPressed(bool value) {
    if (mounted) setState(() => _pressed = value);
  }
}
