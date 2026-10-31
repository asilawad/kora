import 'package:flutter/material.dart';

import 'skeleton_box.dart';
import 'widget_dimensions.dart';

final class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    this.width = WidgetDimensions.skeletonTextWidth,
    this.height = WidgetDimensions.skeletonLineHeight,
    super.key,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => SkeletonBox(
    width: width,
    height: height,
    radius: WidgetDimensions.skeletonLineRadius,
  );
}
