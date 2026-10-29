import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'كورة'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @errorNetwork.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر الاتصال بالإنترنت. تحقّق من اتصالك وحاول مرة أخرى.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In ar, this message translates to:
  /// **'استغرق الطلب وقتًا أطول من المتوقع. حاول مرة أخرى.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ في الخادم. حاول مرة أخرى لاحقًا.'**
  String get errorServer;

  /// No description provided for @errorUnauthorized.
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية الجلسة. سجّل الدخول مرة أخرى.'**
  String get errorUnauthorized;

  /// No description provided for @errorValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى التحقق من البيانات المدخلة والمحاولة مرة أخرى.'**
  String get errorValidation;

  /// No description provided for @errorSlotUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'هذا الموعد لم يعد متاحًا. اختر موعدًا آخر.'**
  String get errorSlotUnavailable;

  /// No description provided for @errorUnknown.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع. حاول مرة أخرى.'**
  String get errorUnknown;

  /// No description provided for @emptyDefaultMessage.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات لعرضها حاليًا.'**
  String get emptyDefaultMessage;

  /// No description provided for @homeFeatured.
  ///
  /// In ar, this message translates to:
  /// **'المميزة'**
  String get homeFeatured;

  /// No description provided for @homePopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر طلبًا'**
  String get homePopular;

  /// No description provided for @homeCourts.
  ///
  /// In ar, this message translates to:
  /// **'الملاعب'**
  String get homeCourts;

  /// No description provided for @homeAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get homeAll;

  /// No description provided for @homeSeeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get homeSeeAll;

  /// No description provided for @homeBookNow.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن'**
  String get homeBookNow;

  /// No description provided for @homeOpenNow.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح الآن'**
  String get homeOpenNow;

  /// No description provided for @homeClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلق'**
  String get homeClosed;

  /// No description provided for @homeClosedNow.
  ///
  /// In ar, this message translates to:
  /// **'مغلق حاليًا'**
  String get homeClosedNow;

  /// No description provided for @homeNoServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات في هذا التصنيف.'**
  String get homeNoServices;

  /// No description provided for @servicesTitle.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get servicesTitle;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن خدمة'**
  String get searchHint;

  /// No description provided for @sortLabel.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب حسب'**
  String get sortLabel;

  /// No description provided for @sortPopular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر شيوعًا'**
  String get sortPopular;

  /// No description provided for @sortPriceAsc.
  ///
  /// In ar, this message translates to:
  /// **'السعر: من الأقل إلى الأعلى'**
  String get sortPriceAsc;

  /// No description provided for @sortPriceDesc.
  ///
  /// In ar, this message translates to:
  /// **'السعر: من الأعلى إلى الأقل'**
  String get sortPriceDesc;

  /// No description provided for @sortDurationAsc.
  ///
  /// In ar, this message translates to:
  /// **'المدة: الأقصر أولًا'**
  String get sortDurationAsc;

  /// No description provided for @sortName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم: أ إلى ي'**
  String get sortName;

  /// No description provided for @resultsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا توجد نتائج} one{نتيجة واحدة} two{نتيجتان} few{{count} نتائج} many{{count} نتيجة} other{{count} نتيجة}}'**
  String resultsCount(num count);

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات متاحة حاليًا.'**
  String get noResults;

  /// No description provided for @noResultsForSearch.
  ///
  /// In ar, this message translates to:
  /// **'لم نعثر على خدمات تطابق بحثك.'**
  String get noResultsForSearch;

  /// No description provided for @loadMoreFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل المزيد. حاول مرة أخرى.'**
  String get loadMoreFailed;

  /// No description provided for @homeCategories.
  ///
  /// In ar, this message translates to:
  /// **'الفئات'**
  String get homeCategories;

  /// No description provided for @homeSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن الملاعب والخدمات'**
  String get homeSearchHint;

  /// No description provided for @authLogin.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get authLogin;

  /// No description provided for @authRegister.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get authRegister;

  /// No description provided for @authName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get authName;

  /// No description provided for @authEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get authEmail;

  /// No description provided for @authPhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get authPhone;

  /// No description provided for @authPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get authPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get authConfirmPassword;

  /// No description provided for @authDeviceName.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق كورة'**
  String get authDeviceName;

  /// No description provided for @authRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب.'**
  String get authRequired;

  /// No description provided for @authPhoneRequired.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم الهاتف.'**
  String get authPhoneRequired;

  /// No description provided for @authInvalidEmail.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدًا إلكترونيًا صحيحًا.'**
  String get authInvalidEmail;

  /// No description provided for @authPasswordMinLength.
  ///
  /// In ar, this message translates to:
  /// **'يجب ألا تقل كلمة المرور عن 6 أحرف.'**
  String get authPasswordMinLength;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين.'**
  String get authPasswordMismatch;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني أو كلمة المرور غير صحيحة.'**
  String get authInvalidCredentials;

  /// No description provided for @authSheetTitle.
  ///
  /// In ar, this message translates to:
  /// **'حسابك في كورة'**
  String get authSheetTitle;

  /// No description provided for @authPasswordVisibility.
  ///
  /// In ar, this message translates to:
  /// **'إظهار كلمة المرور'**
  String get authPasswordVisibility;

  /// No description provided for @authPasswordVisibilityHidden.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء كلمة المرور'**
  String get authPasswordVisibilityHidden;

  /// No description provided for @serviceDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الخدمة'**
  String get serviceDetailsTitle;

  /// No description provided for @serviceWith.
  ///
  /// In ar, this message translates to:
  /// **'مع من؟'**
  String get serviceWith;

  /// No description provided for @serviceAnyCourt.
  ///
  /// In ar, this message translates to:
  /// **'أي ملعب'**
  String get serviceAnyCourt;

  /// No description provided for @serviceChooseTime.
  ///
  /// In ar, this message translates to:
  /// **'اختر الوقت'**
  String get serviceChooseTime;

  /// No description provided for @periodMorning.
  ///
  /// In ar, this message translates to:
  /// **'الصباح'**
  String get periodMorning;

  /// No description provided for @periodAfternoon.
  ///
  /// In ar, this message translates to:
  /// **'بعد الظهر'**
  String get periodAfternoon;

  /// No description provided for @periodEvening.
  ///
  /// In ar, this message translates to:
  /// **'المساء'**
  String get periodEvening;

  /// No description provided for @serviceNoSlots.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أوقات متاحة في هذا اليوم.'**
  String get serviceNoSlots;

  /// No description provided for @serviceBookAt.
  ///
  /// In ar, this message translates to:
  /// **'احجز في {time}'**
  String serviceBookAt(String time);

  /// No description provided for @serviceChooseTimeHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر وقتًا للمتابعة'**
  String get serviceChooseTimeHint;

  /// No description provided for @seatsLeft.
  ///
  /// In ar, this message translates to:
  /// **'متبقٍ {count} مقاعد'**
  String seatsLeft(int count);

  /// No description provided for @attributeSport.
  ///
  /// In ar, this message translates to:
  /// **'الرياضة'**
  String get attributeSport;

  /// No description provided for @attributePlayers.
  ///
  /// In ar, this message translates to:
  /// **'عدد اللاعبين'**
  String get attributePlayers;

  /// No description provided for @attributeLighting.
  ///
  /// In ar, this message translates to:
  /// **'الإضاءة الليلية'**
  String get attributeLighting;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @relatedServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات ذات صلة'**
  String get relatedServices;

  /// No description provided for @serviceDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get serviceDescription;

  /// No description provided for @serviceAttributes.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get serviceAttributes;

  /// No description provided for @serviceRatingCount.
  ///
  /// In ar, this message translates to:
  /// **'({count})'**
  String serviceRatingCount(int count);

  /// No description provided for @bookingConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحجز'**
  String get bookingConfirmTitle;

  /// No description provided for @bookingConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحجز'**
  String get bookingConfirm;

  /// No description provided for @bookingCashAtVenue.
  ///
  /// In ar, this message translates to:
  /// **'الدفع نقدًا في الملعب'**
  String get bookingCashAtVenue;

  /// No description provided for @bookingNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get bookingNotesHint;

  /// No description provided for @bookingRulesNote.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك الإلغاء قبل الموعد بـ {hours} ساعات على الأقل، والاحتفاظ بما يصل إلى {count} حجوزات نشطة.'**
  String bookingRulesNote(int hours, int count);

  /// No description provided for @bookingCourt.
  ///
  /// In ar, this message translates to:
  /// **'الملعب'**
  String get bookingCourt;

  /// No description provided for @bookingDateTime.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ والوقت'**
  String get bookingDateTime;

  /// No description provided for @bookingDurationLabel.
  ///
  /// In ar, this message translates to:
  /// **'المدة'**
  String get bookingDurationLabel;

  /// No description provided for @bookingTotalPrice.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get bookingTotalPrice;

  /// No description provided for @bookingDuration.
  ///
  /// In ar, this message translates to:
  /// **'{minutes} دقيقة'**
  String bookingDuration(int minutes);

  /// No description provided for @bookingPayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get bookingPayment;

  /// No description provided for @bookingSuccessTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد الحجز'**
  String get bookingSuccessTitle;

  /// No description provided for @bookingNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الحجز: {number}'**
  String bookingNumber(String number);

  /// No description provided for @bookingCode.
  ///
  /// In ar, this message translates to:
  /// **'رمز الحجز: {code}'**
  String bookingCode(String code);

  /// No description provided for @bookingViewBookings.
  ///
  /// In ar, this message translates to:
  /// **'عرض حجوزاتي'**
  String get bookingViewBookings;

  /// No description provided for @bookingBackHome.
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get bookingBackHome;

  /// No description provided for @bookingsPlaceholderTitle.
  ///
  /// In ar, this message translates to:
  /// **'حجوزاتي'**
  String get bookingsPlaceholderTitle;

  /// No description provided for @bookingsPlaceholderMessage.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر حجوزاتك هنا.'**
  String get bookingsPlaceholderMessage;

  /// No description provided for @myBookingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'حجوزاتي'**
  String get myBookingsTitle;

  /// No description provided for @myBookingsUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'القادمة'**
  String get myBookingsUpcoming;

  /// No description provided for @myBookingsPast.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get myBookingsPast;

  /// No description provided for @myBookingsSignedOut.
  ///
  /// In ar, this message translates to:
  /// **'سجّل الدخول لعرض حجوزاتك.'**
  String get myBookingsSignedOut;

  /// No description provided for @myBookingsLogin.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get myBookingsLogin;

  /// No description provided for @myBookingsCancellationUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'لم يعد الإلغاء متاحًا.'**
  String get myBookingsCancellationUnavailable;

  /// No description provided for @myBookingsCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الحجز'**
  String get myBookingsCancel;

  /// No description provided for @myBookingsCancelTitle.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء هذا الحجز؟'**
  String get myBookingsCancelTitle;

  /// No description provided for @myBookingsCancelMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رغبتك في إلغاء هذا الحجز؟'**
  String get myBookingsCancelMessage;

  /// No description provided for @myBookingsCancelReason.
  ///
  /// In ar, this message translates to:
  /// **'السبب (اختياري)'**
  String get myBookingsCancelReason;

  /// No description provided for @myBookingsCancelLateWarning.
  ///
  /// In ar, this message translates to:
  /// **'قد يُحتسب هذا الإلغاء متأخرًا.'**
  String get myBookingsCancelLateWarning;

  /// No description provided for @myBookingsKeepBooking.
  ///
  /// In ar, this message translates to:
  /// **'الاحتفاظ بالحجز'**
  String get myBookingsKeepBooking;

  /// No description provided for @myBookingsConfirmCancel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الإلغاء'**
  String get myBookingsConfirmCancel;

  /// No description provided for @myBookingsLogout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get myBookingsLogout;

  /// No description provided for @myBookingsLogoutTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج؟'**
  String get myBookingsLogoutTitle;

  /// No description provided for @myBookingsLogoutMessage.
  ///
  /// In ar, this message translates to:
  /// **'ستحتاج إلى تسجيل الدخول مجددًا لعرض حجوزاتك.'**
  String get myBookingsLogoutMessage;

  /// No description provided for @myBookingsCancelSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الحجز.'**
  String get myBookingsCancelSuccess;

  /// No description provided for @myBookingsCancelFailure.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إلغاء هذا الحجز.'**
  String get myBookingsCancelFailure;

  /// No description provided for @myBookingsLoadMore.
  ///
  /// In ar, this message translates to:
  /// **'تحميل المزيد'**
  String get myBookingsLoadMore;

  /// No description provided for @myBookingsStatusConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'مؤكد'**
  String get myBookingsStatusConfirmed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
