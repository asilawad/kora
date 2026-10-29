// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navigationHome => 'الرئيسية';

  @override
  String get navigationBookings => 'حجوزاتي';

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

  @override
  String get servicesTitle => 'الخدمات';

  @override
  String get searchHint => 'ابحث عن خدمة';

  @override
  String get sortLabel => 'ترتيب حسب';

  @override
  String get sortPopular => 'الأكثر شيوعًا';

  @override
  String get sortPriceAsc => 'السعر: من الأقل إلى الأعلى';

  @override
  String get sortPriceDesc => 'السعر: من الأعلى إلى الأقل';

  @override
  String get sortDurationAsc => 'المدة: الأقصر أولًا';

  @override
  String get sortName => 'الاسم: أ إلى ي';

  @override
  String resultsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتيجة',
      many: '$count نتيجة',
      few: '$count نتائج',
      two: 'نتيجتان',
      one: 'نتيجة واحدة',
      zero: 'لا توجد نتائج',
    );
    return '$_temp0';
  }

  @override
  String get noResults => 'لا توجد خدمات متاحة حاليًا.';

  @override
  String get noResultsForSearch => 'لم نعثر على خدمات تطابق بحثك.';

  @override
  String get loadMoreFailed => 'تعذّر تحميل المزيد. حاول مرة أخرى.';

  @override
  String get homeCategories => 'الفئات';

  @override
  String get homeSearchHint => 'ابحث عن الملاعب والخدمات';

  @override
  String get authLogin => 'تسجيل الدخول';

  @override
  String get authRegister => 'إنشاء حساب';

  @override
  String get authName => 'الاسم الكامل';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPhone => 'رقم الهاتف';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get authDeviceName => 'تطبيق كورة';

  @override
  String get authRequired => 'هذا الحقل مطلوب.';

  @override
  String get authPhoneRequired => 'أدخل رقم الهاتف.';

  @override
  String get authInvalidEmail => 'أدخل بريدًا إلكترونيًا صحيحًا.';

  @override
  String get authPasswordMinLength => 'يجب ألا تقل كلمة المرور عن 6 أحرف.';

  @override
  String get authPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get authInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get authSheetTitle => 'حسابك في كورة';

  @override
  String get authPasswordVisibility => 'إظهار كلمة المرور';

  @override
  String get authPasswordVisibilityHidden => 'إخفاء كلمة المرور';

  @override
  String get serviceDetailsTitle => 'تفاصيل الخدمة';

  @override
  String get serviceWith => 'مع من؟';

  @override
  String get serviceAnyCourt => 'أي ملعب';

  @override
  String get serviceChooseTime => 'اختر الوقت';

  @override
  String get periodMorning => 'الصباح';

  @override
  String get periodAfternoon => 'بعد الظهر';

  @override
  String get periodEvening => 'المساء';

  @override
  String get serviceNoSlots => 'لا توجد أوقات متاحة في هذا اليوم.';

  @override
  String serviceBookAt(String time) {
    return 'احجز في $time';
  }

  @override
  String get serviceChooseTimeHint => 'اختر وقتًا للمتابعة';

  @override
  String seatsLeft(int count) {
    return 'متبقٍ $count مقاعد';
  }

  @override
  String get attributeSport => 'الرياضة';

  @override
  String get attributePlayers => 'عدد اللاعبين';

  @override
  String get attributeLighting => 'الإضاءة الليلية';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get relatedServices => 'خدمات ذات صلة';

  @override
  String get serviceDescription => 'الوصف';

  @override
  String get serviceAttributes => 'التفاصيل';

  @override
  String serviceRatingCount(int count) {
    return '($count)';
  }

  @override
  String get bookingConfirmTitle => 'تأكيد الحجز';

  @override
  String get bookingConfirm => 'تأكيد الحجز';

  @override
  String get bookingCashAtVenue => 'الدفع نقدًا في الملعب';

  @override
  String get bookingNotesHint => 'ملاحظات (اختياري)';

  @override
  String bookingRulesNote(int hours, int count) {
    return 'يمكنك الإلغاء قبل الموعد بـ $hours ساعات على الأقل، والاحتفاظ بما يصل إلى $count حجوزات نشطة.';
  }

  @override
  String get bookingCourt => 'الملعب';

  @override
  String get bookingDateTime => 'التاريخ والوقت';

  @override
  String get bookingDurationLabel => 'المدة';

  @override
  String get bookingTotalPrice => 'الإجمالي';

  @override
  String bookingDuration(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get bookingPayment => 'الدفع';

  @override
  String get bookingSuccessTitle => 'تم تأكيد الحجز';

  @override
  String bookingNumber(String number) {
    return 'رقم الحجز: $number';
  }

  @override
  String bookingCode(String code) {
    return 'رمز الحجز: $code';
  }

  @override
  String get bookingViewBookings => 'عرض حجوزاتي';

  @override
  String get bookingBackHome => 'العودة للرئيسية';

  @override
  String get bookingsPlaceholderTitle => 'حجوزاتي';

  @override
  String get bookingsPlaceholderMessage => 'ستظهر حجوزاتك هنا.';

  @override
  String get myBookingsTitle => 'حجوزاتي';

  @override
  String get myBookingsUpcoming => 'القادمة';

  @override
  String get myBookingsPast => 'السابقة';

  @override
  String get myBookingsSignedOut => 'سجّل الدخول لعرض حجوزاتك.';

  @override
  String get myBookingsLogin => 'تسجيل الدخول';

  @override
  String get myBookingsCancellationUnavailable => 'لم يعد الإلغاء متاحًا.';

  @override
  String get myBookingsCancel => 'إلغاء الحجز';

  @override
  String get myBookingsCancelTitle => 'إلغاء هذا الحجز؟';

  @override
  String get myBookingsCancelMessage =>
      'هل أنت متأكد من رغبتك في إلغاء هذا الحجز؟';

  @override
  String get myBookingsCancelReason => 'السبب (اختياري)';

  @override
  String get myBookingsCancelLateWarning => 'قد يُحتسب هذا الإلغاء متأخرًا.';

  @override
  String get myBookingsKeepBooking => 'الاحتفاظ بالحجز';

  @override
  String get myBookingsConfirmCancel => 'تأكيد الإلغاء';

  @override
  String get myBookingsLogout => 'تسجيل الخروج';

  @override
  String get myBookingsLogoutTitle => 'تسجيل الخروج؟';

  @override
  String get myBookingsLogoutMessage =>
      'ستحتاج إلى تسجيل الدخول مجددًا لعرض حجوزاتك.';

  @override
  String get myBookingsCancelSuccess => 'تم إلغاء الحجز.';

  @override
  String get myBookingsCancelFailure => 'تعذّر إلغاء هذا الحجز.';

  @override
  String get myBookingsLoadMore => 'تحميل المزيد';

  @override
  String get myBookingsStatusConfirmed => 'مؤكد';
}
