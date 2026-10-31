import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../home/domain/entities/service_entity.dart';
import 'service_details_dimensions.dart';

final class ServiceGallery extends StatefulWidget {
  const ServiceGallery({required this.service, super.key});

  final ServiceEntity service;

  @override
  State<ServiceGallery> createState() => _ServiceGalleryState();
}

final class _ServiceGalleryState extends State<ServiceGallery> {
  int _currentPage = 0;

  List<String> get _images => widget.service.images.isEmpty
      ? [widget.service.image.isEmpty ? widget.service.thumb : widget.service.image]
      : widget.service.images.map((image) => image.url).toList();

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: ServiceDetailsDimensions.galleryAspectRatio,
    child: Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: _images.length,
          onPageChanged: (page) => setState(() => _currentPage = page),
          itemBuilder: (context, index) =>
              _ServiceGalleryImage(url: _images[index]),
        ),
        const IgnorePointer(child: _GalleryTopScrim()),
        PositionedDirectional(
          top: ServiceDetailsDimensions.galleryBackButtonInset +
              MediaQuery.paddingOf(context).top,
          start: ServiceDetailsDimensions.galleryBackButtonInset,
          child: const _GalleryBackButton(),
        ),
        if (_images.length > 1) ...[
          PositionedDirectional(
            bottom: ServiceDetailsDimensions.galleryDotsBottom,
            start: 0,
            end: 0,
            child: _GalleryDots(count: _images.length, current: _currentPage),
          ),
          PositionedDirectional(
            bottom: ServiceDetailsDimensions.galleryDotsBottom,
            end: ServiceDetailsDimensions.galleryBackButtonInset,
            child: _GalleryCounter(
              text: '${_currentPage + 1}/${_images.length}',
            ),
          ),
        ],
      ],
    ),
  );
}

final class _GalleryTopScrim extends StatelessWidget {
  const _GalleryTopScrim();

  @override
  Widget build(BuildContext context) => const DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [Color(0x66000000), AppColors.transparent],
      ),
    ),
  );
}

final class _GalleryBackButton extends StatelessWidget {
  const _GalleryBackButton();

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: AppColors.surface,
      shape: BoxShape.circle,
      boxShadow: AppShadows.card,
    ),
    child: const BackButton(color: AppColors.textPrimary),
  );
}

final class _GalleryDots extends StatelessWidget {
  const _GalleryDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List<Widget>.generate(
      count,
      (index) => AnimatedContainer(
        duration: ServiceDetailsDimensions.galleryIndicatorDuration,
        margin: const EdgeInsetsDirectional.symmetric(
          horizontal: ServiceDetailsDimensions.smallSpacing / 2,
        ),
        width: index == current
            ? ServiceDetailsDimensions.galleryActiveDotWidth
            : ServiceDetailsDimensions.galleryDotSize,
        height: ServiceDetailsDimensions.galleryDotSize,
        decoration: BoxDecoration(
          color: index == current
              ? AppColors.surface
              : AppColors.surface.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    ),
  );
}

final class _GalleryCounter extends StatelessWidget {
  const _GalleryCounter({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: ServiceDetailsDimensions.itemSpacing,
      vertical: ServiceDetailsDimensions.smallSpacing / 2,
    ),
    decoration: BoxDecoration(
      color: AppColors.textPrimary.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.onPrimary,
      ),
    ),
  );
}

final class _ServiceGalleryImage extends StatelessWidget {
  const _ServiceGalleryImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) => url.isEmpty
      ? const ColoredBox(
          color: AppColors.grey100,
          child: AppNetworkImageErrorPlaceholder(),
        )
      : AppNetworkImage(url: url);
}
