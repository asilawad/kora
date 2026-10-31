import '../../../../core/theme/app_durations.dart';

abstract final class HomeDimensions {
  static const double pagePadding = 16;
  static const double sectionSpacing = 32;
  static const double itemSpacing = 16;
  static const double smallSpacing = 8;
  static const double tapTargetHeight = 48;
  static const double logoSize = 56;
  static const double coverAspectRatio = 1.8;
  static const double featuredCardWidth = 240;
  static const double featuredCardInfoHeight = 132;
  static const double featuredCardMargin = 0;
  static const double featuredListHeight =
      featuredImageHeight +
      featuredCardInfoHeight +
      featuredCardMargin * 2;
  static const double featuredImageHeight = 180;
  static const double featuredCardImageHeight = 144;
  static const double serviceImageSize = 96;
  static const double serviceCardPadding = 16;
  static const double serviceCardRadius = 24;
  static const double categoryRadius = 999;
  static const double courtAvatarSize = 64;
  static const double courtRowHeight = 120;
  static const double courtRingWidth = 3;
  static const double courtItemWidth = 84;
  static const double discountRadius = 999;
  static const double discountHorizontalPadding = 8;
  static const double discountVerticalPadding = 4;
  static const double badgeOverlayOpacity = 0.12;
  static const double categoryBorderWidth = 1;
  static const double durationIconSize = 16;
  static const double durationIconGap = 4;
  static const double statusDotSize = 8;
  static const double statusDotGap = 6;
  static const double serviceBookButtonHeight = 48;
  static const double serviceBookButtonHorizontalPadding = 12;
  static const double serviceCardBorderWidth = 1;
  static const double transparentOpacity = 0;
  static const double categoryCardWidth = 88;
  static const double categoryCardHeight = 112;
  static const double homeSearchHeight = 52;
  static const double homeSearchRadius = 999;
  static const double categoryFallbackIconSize = 32;
  static const double coverHeight = 240;
  static const double coverOverlap = 48;
  static const double coverLogoBorder = 2;
  static const double coverScrimOpacity = 0.28;
  static const double floatingPlaceCardHeight = 140;
  static const double floatingCardPadding = 16;
  static const double locationIconSize = 16;
  static const double locationIconGap = 4;
  static const double coverImageFallbackIconSize = 44;
  static const double categoryImageSize = 68;
  static const double categoryImageFallbackIconSize = 28;
  static const double offerViewportFraction = 0.88;
  static const double offerHeight = 220;
  static const double offerBottomGradientOpacity = 0.82;
  static const double offerDotHeight = 6;
  static const double offerDotWidth = 6;
  static const double offerActiveDotWidth = 20;
  static const double offerDotGap = 6;
  static const double offerBookButtonHeight = 48;
  static const double offerButtonRadius = 999;
  static const double offerGradientStart = 0.15;
  static const double offerGradientEnd = 1;
  static const double durationPillIconSize = 14;
  static const double durationPillPadding = 8;
  static const double bookButtonWidth = 64;
  static const double featuredImageRadius = 24;
  static const double durationPillHeight = 32;
  static const double durationPillIconGap = 4;
  static const double featuredContentPadding = 16;
  static const double serviceBookButtonWidth = 64;
  static const double serviceMetaGap = 4;
  static const double serviceAttributePillHorizontal = 8;
  static const double serviceAttributePillVertical = 2;
  static const double listFadeDistance = 0;
  static const Duration indicatorDuration = AppDurations.fast;
  static const double sectionAnimationSlide = 0.06;
  static const double sectionAnimationHidden = 0;
  static const double sectionAnimationStart = 0.08;
  static const double sectionAnimationEnd = 1;
  static const double skeletonPlaceNameWidth = 160;
  static const double skeletonAddressWidth = 120;
  static const double skeletonCategoryNameWidth = 56;
  static const double skeletonServiceCardHeight = 128;
  static const int skeletonCategoryCount = 4;
  static const int skeletonServiceCount = 3;
  static const int offerAutoAdvanceSeconds = 5;
  static const int sectionStaggerMilliseconds = 45;
  static const Duration sectionDelay0 = Duration.zero;
  static const Duration sectionDelay1 = Duration(
    milliseconds: sectionStaggerMilliseconds,
  );
  static const Duration sectionDelay2 = Duration(
    milliseconds: sectionStaggerMilliseconds * 2,
  );
  static const Duration sectionDelay3 = Duration(
    milliseconds: sectionStaggerMilliseconds * 3,
  );
  static const Duration sectionDelay4 = Duration(
    milliseconds: sectionStaggerMilliseconds * 4,
  );
  static const Duration sectionDelay5 = Duration(
    milliseconds: sectionStaggerMilliseconds * 5,
  );
  static const Duration sectionDelay6 = Duration(
    milliseconds: sectionStaggerMilliseconds * 6,
  );
  static const Duration offerAutoAdvanceDuration = Duration(
    seconds: offerAutoAdvanceSeconds,
  );
  static const Duration scrollToTopDuration = AppDurations.normal;
}
