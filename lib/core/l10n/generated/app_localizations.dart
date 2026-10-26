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
