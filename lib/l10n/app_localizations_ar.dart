// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب؟ سجل الدخول';

  @override
  String get signupValidation => 'يرجى ملء جميع الحقول واستخدام كلمة مرور من 6 أحرف على الأقل.';

  @override
  String get signupSuccessTitle => 'تم إنشاء الحساب!';

  @override
  String get signupSuccessBody => 'تم إنشاء حسابك بنجاح. يرجى تسجيل الدخول للمتابعة.';

  @override
  String signupFailed(Object error) {
    return 'فشل التسجيل: $error';
  }

  @override
  String welcome(Object name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get enterEmailReset => 'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة التعيين.';

  @override
  String get sendResetLink => 'إرسال الرابط';

  @override
  String get resetLinkSent => 'تم إرسال رابط إعادة التعيين!';

  @override
  String get checkInbox => 'لقد أرسلنا رابطًا إلى بريدك الإلكتروني لإعادة تعيين كلمة المرور. يرجى التحقق من بريدك الوارد.';

  @override
  String get home => 'الرئيسية';

  @override
  String get messages => 'الرسائل';

  @override
  String get settings => 'الإعدادات';

  @override
  String get noNotifications => 'لا توجد إشعارات جديدة';

  @override
  String get dashboardPlaceholder => 'محتوى لوحة التحكم يظهر هنا';

  @override
  String get messagesSoon => 'صفحة الرسائل ستتوفر قريبًا';

  @override
  String get settingsSoon => 'صفحة الإعدادات ستتوفر قريبًا';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get english => 'English';

  @override
  String get malay => 'Malay';

  @override
  String get arabic => 'Arabic';

  @override
  String get bengali => 'Bengali';

  @override
  String get chinese => 'Chinese';

  @override
  String get return_ => 'رجوع';

  @override
  String get ok => 'حسنًا';

  @override
  String get accountCreated => 'تم إنشاء الحساب بنجاح!';

  @override
  String get welcomePlatform => 'مرحبًا';

  @override
  String get copyright => 'جميع الحقوق محفوظة. © جامعة LUC ماليزيا 2025.';
}
