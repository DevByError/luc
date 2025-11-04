// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get login => 'Log In';

  @override
  String get signup => 'Sign Up';

  @override
  String get createAccount => 'Create Account';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get signupValidation => 'Please fill all fields and use at least a 6-character password.';

  @override
  String get signupSuccessTitle => 'Signup Successful!';

  @override
  String get signupSuccessBody => 'Your account has been created successfully. Please log in to continue.';

  @override
  String signupFailed(Object error) {
    return 'Signup failed: $error';
  }

  @override
  String welcome(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterEmailReset => 'Enter your email and we’ll send you a reset link.';

  @override
  String get sendResetLink => 'Send Link';

  @override
  String get resetLinkSent => 'Reset link sent!';

  @override
  String get checkInbox => 'We’ve sent a link to your email to reset your password. Please check your inbox.';

  @override
  String get home => 'Home';

  @override
  String get messages => 'Messages';

  @override
  String get settings => 'Settings';

  @override
  String get noNotifications => 'No new notifications';

  @override
  String get dashboardPlaceholder => 'Dashboard content goes here';

  @override
  String get messagesSoon => 'Messages page coming soon';

  @override
  String get settingsSoon => 'Settings page coming soon';

  @override
  String get logout => 'Logout';

  @override
  String get profile => 'Profile';

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
  String get return_ => 'Return';

  @override
  String get ok => 'OK';

  @override
  String get accountCreated => 'Account created successfully!';

  @override
  String get welcomePlatform => 'Welcome';

  @override
  String get copyright => 'All Copyrights Reserved. © LUC Malaysia 2025.';
}
