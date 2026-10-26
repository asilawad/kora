// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'كورة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get errorNetwork =>
      'تعذّر الاتصال بالإنترنت. تحقّق من اتصالك وحاول مرة أخرى.';

  @override
  String get errorTimeout =>
      'استغرق الطلب وقتًا أطول من المتوقع. حاول مرة أخرى.';

  @override
  String get errorServer => 'حدث خطأ في الخادم. حاول مرة أخرى لاحقًا.';

  @override
  String get errorUnauthorized => 'انتهت صلاحية الجلسة. سجّل الدخول مرة أخرى.';

  @override
  String get errorValidation =>
      'يرجى التحقق من البيانات المدخلة والمحاولة مرة أخرى.';

  @override
  String get errorSlotUnavailable =>
      'هذا الموعد لم يعد متاحًا. اختر موعدًا آخر.';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get emptyDefaultMessage => 'لا توجد بيانات لعرضها حاليًا.';

  @override
  String get homeFeatured => 'المميزة';

  @override
  String get homePopular => 'الأكثر طلبًا';

  @override
  String get homeCourts => 'الملاعب';

  @override
  String get homeAll => 'الكل';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String get homeBookNow => 'احجز الآن';

  @override
  String get homeOpenNow => 'مفتوح الآن';

  @override
  String get homeClosed => 'مغلق';

  @override
  String get homeClosedNow => 'مغلق حاليًا';

  @override
  String get homeNoServices => 'لا توجد خدمات في هذا التصنيف.';
}
