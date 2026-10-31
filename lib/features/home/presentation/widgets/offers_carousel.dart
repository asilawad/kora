import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/entities/service_entity.dart';
import 'home_dimensions.dart';
import 'offer_page_indicator.dart';
import 'offer_slide.dart';
import 'section_header.dart';

final class OffersCarousel extends StatefulWidget {
  const OffersCarousel({
    required this.featured,
    required this.popular,
    required this.currencySymbol,
    required this.onServiceTap,
    super.key,
  });

  final List<ServiceEntity> featured;
  final List<ServiceEntity> popular;
  final String currencySymbol;
  final ValueChanged<ServiceEntity> onServiceTap;

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

final class _OffersCarouselState extends State<OffersCarousel> {
  late final PageController _controller = PageController(
    viewportFraction: HomeDimensions.offerViewportFraction,
  );
  Timer? _timer;
  int _currentPage = 0;
  bool _isTouching = false;

  List<ServiceEntity> get _offers {
    final byId = <int, ServiceEntity>{};
    for (final service in [...widget.featured, ...widget.popular]) {
      if (service.discountPercent != null) {
        byId.putIfAbsent(service.id, () => service);
      }
    }
    return byId.values.toList(growable: false);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant OffersCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_offers.length != _previousOfferCount(oldWidget)) _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offers = _offers;
    if (offers.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: AppLocalizations.of(context)!.homeOffers),
        const SizedBox(height: HomeDimensions.itemSpacing),
        Listener(
          onPointerDown: (_) => _pause(),
          onPointerUp: (_) => _resume(),
          onPointerCancel: (_) => _resume(),
          child: SizedBox(
            height: HomeDimensions.offerHeight,
            child: PageView.builder(
              controller: _controller,
              itemCount: offers.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: HomeDimensions.itemSpacing,
                ),
                child: OfferSlide(
                  service: offers[index],
                  currencySymbol: widget.currencySymbol,
                  onServiceTap: () => widget.onServiceTap(offers[index]),
                  onBook: () => widget.onServiceTap(offers[index]),
                ),
              ),
            ),
          ),
        ),
        if (offers.length > 1)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: HomeDimensions.itemSpacing,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var index = 0; index < offers.length; index++)
                  OfferPageIndicator(selected: index == _currentPage),
              ],
            ),
          ),
      ],
    );
  }

  int _previousOfferCount(OffersCarousel oldWidget) {
    final ids = <int>{};
    for (final service in [...oldWidget.featured, ...oldWidget.popular]) {
      if (service.discountPercent != null) ids.add(service.id);
    }
    return ids.length;
  }

  void _startTimer() {
    _timer?.cancel();
    if (_offers.length <= 1 || _isTouching) return;
    _timer = Timer.periodic(HomeDimensions.offerAutoAdvanceDuration, (_) {
      if (!_controller.hasClients || _isTouching) return;
      final nextPage = (_currentPage + 1) % _offers.length;
      _controller.animateToPage(
        nextPage,
        duration: HomeDimensions.indicatorDuration,
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _pause() {
    _isTouching = true;
    _timer?.cancel();
  }

  void _resume() {
    _isTouching = false;
    _startTimer();
  }
}
