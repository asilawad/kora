import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'widget_dimensions.dart';

final class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.aspectRatio,
    this.placeholder,
    this.errorPlaceholder,
    super.key,
  });

  final String url;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  final double? aspectRatio;
  final Widget? placeholder;
  final Widget? errorPlaceholder;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: aspectRatio == null
        ? _CachedImage(
            url: url,
            fit: fit,
            placeholder: placeholder,
            errorPlaceholder: errorPlaceholder,
          )
        : AspectRatio(
            aspectRatio: aspectRatio!,
            child: _CachedImage(
              url: url,
              fit: fit,
              placeholder: placeholder,
              errorPlaceholder: errorPlaceholder,
            ),
          ),
  );
}

final class _CachedImage extends StatelessWidget {
  const _CachedImage({
    required this.url,
    required this.fit,
    this.placeholder,
    this.errorPlaceholder,
  });

  final String url;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorPlaceholder;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
    imageUrl: url,
    fit: fit,
    placeholder: (context, url) =>
        placeholder ?? const AppNetworkImagePlaceholder(),
    errorWidget: (context, url, error) =>
        errorPlaceholder ?? const AppNetworkImageErrorPlaceholder(),
  );
}

final class AppNetworkImagePlaceholder extends StatelessWidget {
  const AppNetworkImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: SizedBox(
      width: WidgetDimensions.loaderSize,
      height: WidgetDimensions.loaderSize,
      child: CircularProgressIndicator(
        strokeWidth: WidgetDimensions.loaderStrokeWidth,
      ),
    ),
  );
}

final class AppNetworkImageErrorPlaceholder extends StatelessWidget {
  const AppNetworkImageErrorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: Icon(Icons.image_not_supported_outlined),
  );
}
