// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get email => 'Emel';

  @override
  String get emailAddress => 'Alamat Emel';

  @override
  String get password => 'Kata Laluan';

  @override
  String get fullName => 'Nama Penuh';

  @override
  String get login => 'Log Masuk';

  @override
  String get signup => 'Daftar';

  @override
  String get createAccount => 'Buat Akaun';

  @override
  String get forgotPassword => 'Lupa Kata Laluan?';

  @override
  String get alreadyHaveAccount => 'Sudah ada akaun? Log masuk';

  @override
  String get signupValidation => 'Sila isi semua ruangan dan gunakan kata laluan sekurang-kurangnya 6 aksara.';

  @override
  String get signupSuccessTitle => 'Pendaftaran Berjaya!';

  @override
  String get signupSuccessBody => 'Akaun anda telah berjaya dibuat. Sila log masuk untuk meneruskan.';

  @override
  String signupFailed(Object error) {
    return 'Pendaftaran gagal: $error';
  }

  @override
  String welcome(Object name) {
    return 'Selamat datang, $name!';
  }

  @override
  String get resetPassword => 'Tetapkan Semula Kata Laluan';

  @override
  String get enterEmailReset => 'Masukkan emel anda dan kami akan menghantar pautan tetapan semula.';

  @override
  String get sendResetLink => 'Hantar Pautan';

  @override
  String get resetLinkSent => 'Pautan telah dihantar!';

  @override
  String get checkInbox => 'Kami telah menghantar pautan ke emel anda. Sila semak peti masuk.';

  @override
  String get home => 'Laman Utama';

  @override
  String get messages => 'Mesej';

  @override
  String get settings => 'Tetapan';

  @override
  String get noNotifications => 'Tiada notifikasi baru';

  @override
  String get dashboardPlaceholder => 'Kandungan papan pemuka dipaparkan di sini';

  @override
  String get messagesSoon => 'Halaman mesej akan datang tidak lama lagi';

  @override
  String get settingsSoon => 'Halaman tetapan akan datang tidak lama lagi';

  @override
  String get logout => 'Log Keluar';

  @override
  String get profile => 'Profil';

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
  String get return_ => 'Kembali';

  @override
  String get ok => 'OK';

  @override
  String get accountCreated => 'Akaun berjaya dibuat!';

  @override
  String get welcomePlatform => 'Selamat datang';

  @override
  String get copyright => 'Hak Cipta Terpelihara. © LUC Malaysia 2025.';
}
