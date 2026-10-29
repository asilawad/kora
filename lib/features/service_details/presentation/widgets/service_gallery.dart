import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
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
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: const BorderRadius.vertical(
      bottom: Radius.circular(ServiceDetailsDimensions.galleryRadius),
    ),
    child: AspectRatio(
      aspectRatio: ServiceDetailsDimensions.galleryAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: _images.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) => _ServiceGalleryImage(
              url: _images[index],
            ),
          ),
          PositionedDirectional(
            top: ServiceDetailsDimensions.galleryBackButtonInset,
            start: ServiceDetailsDimensions.galleryBackButtonInset,
            child: Material(
              color: AppColors.surface.withValues(
                alpha: ServiceDetailsDimensions.surfaceOverlayOpacity,
              ),
              shape: const CircleBorder(),
              child: const BackButton(),
            ),
          ),
          if (_images.length > 1)
            PositionedDirectional(
              bottom: ServiceDetailsDimensions.galleryDotsBottom,
              start: 0,
              end: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  _images.length,
                  (index) => AnimatedContainer(
                    duration:
                        ServiceDetailsDimensions.galleryIndicatorDuration,
                    margin: const EdgeInsetsDirectional.symmetric(
                      horizontal: ServiceDetailsDimensions.smallSpacing / 2,
                    ),
                    width: index == _currentPage
                        ? ServiceDetailsDimensions.galleryActiveDotWidth
                        : ServiceDetailsDimensions.galleryDotSize,
                    height: ServiceDetailsDimensions.galleryDotSize,
                    decoration: BoxDecoration(
                      color: index == _currentPage
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        ServiceDetailsDimensions.galleryDotSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
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
