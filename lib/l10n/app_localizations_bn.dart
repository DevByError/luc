// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get email => 'ইমেইল';

  @override
  String get emailAddress => 'ইমেইল ঠিকানা';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get fullName => 'পূর্ণ নাম';

  @override
  String get login => 'লগ ইন';

  @override
  String get signup => 'সাইন আপ';

  @override
  String get createAccount => 'একটি অ্যাকাউন্ট তৈরি করুন';

  @override
  String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন?';

  @override
  String get alreadyHaveAccount => 'ইতিমধ্যে একটি অ্যাকাউন্ট আছে? লগ ইন করুন';

  @override
  String get signupValidation => 'অনুগ্রহ করে সব ক্ষেত্র পূরণ করুন এবং কমপক্ষে ৬ অক্ষরের পাসওয়ার্ড ব্যবহার করুন।';

  @override
  String get signupSuccessTitle => 'সাইনআপ সফল!';

  @override
  String get signupSuccessBody => 'আপনার অ্যাকাউন্ট সফলভাবে তৈরি হয়েছে। দয়া করে লগ ইন করুন।';

  @override
  String signupFailed(Object error) {
    return 'সাইনআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String welcome(Object name) {
    return 'স্বাগতম, $name!';
  }

  @override
  String get resetPassword => 'পাসওয়ার্ড রিসেট করুন';

  @override
  String get enterEmailReset => 'আপনার ইমেইল দিন, আমরা একটি রিসেট লিংক পাঠাবো।';

  @override
  String get sendResetLink => 'লিংক পাঠান';

  @override
  String get resetLinkSent => 'রিসেট লিংক পাঠানো হয়েছে!';

  @override
  String get checkInbox => 'আমরা আপনার ইমেইলে একটি লিংক পাঠিয়েছি। দয়া করে ইনবক্স চেক করুন।';

  @override
  String get home => 'হোম';

  @override
  String get messages => 'বার্তা';

  @override
  String get settings => 'সেটিংস';

  @override
  String get noNotifications => 'নতুন কোনো নোটিফিকেশন নেই';

  @override
  String get dashboardPlaceholder => 'ড্যাশবোর্ড কন্টেন্ট এখানে প্রদর্শিত হবে';

  @override
  String get messagesSoon => 'বার্তা পৃষ্ঠা শীঘ্রই আসছে';

  @override
  String get settingsSoon => 'সেটিংস পৃষ্ঠা শীঘ্রই আসছে';

  @override
  String get logout => 'লগ আউট';

  @override
  String get profile => 'প্রোফাইল';

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
  String get return_ => 'ফিরে যান';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get accountCreated => 'অ্যাকাউন্ট সফলভাবে তৈরি হয়েছে!';

  @override
  String get welcomePlatform => 'স্বাগতম';

  @override
  String get copyright => 'সমস্ত স্বত্ব সংরক্ষিত। © এলইউসি মালয়েশিয়া ২০২৫।';
}
