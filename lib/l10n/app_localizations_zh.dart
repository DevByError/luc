// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get email => '电子邮件';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get password => '密码';

  @override
  String get fullName => '全名';

  @override
  String get login => '登录';

  @override
  String get signup => '注册';

  @override
  String get createAccount => '创建账户';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get alreadyHaveAccount => '已有账号？登录';

  @override
  String get signupValidation => '请填写所有字段并使用至少6个字符的密码。';

  @override
  String get signupSuccessTitle => '注册成功！';

  @override
  String get signupSuccessBody => '您的账户已成功创建。请登录以继续。';

  @override
  String signupFailed(Object error) {
    return '注册失败：$error';
  }

  @override
  String welcome(Object name) {
    return '欢迎，$name！';
  }

  @override
  String get resetPassword => '重置密码';

  @override
  String get enterEmailReset => '请输入您的电子邮件地址，我们将发送重置链接。';

  @override
  String get sendResetLink => '发送链接';

  @override
  String get resetLinkSent => '重置链接已发送！';

  @override
  String get checkInbox => '我们已向您的邮箱发送了重置密码的链接，请检查您的收件箱。';

  @override
  String get home => '主页';

  @override
  String get messages => '消息';

  @override
  String get settings => '设置';

  @override
  String get noNotifications => '没有新通知';

  @override
  String get dashboardPlaceholder => '仪表板内容将在此处显示';

  @override
  String get messagesSoon => '消息页面即将推出';

  @override
  String get settingsSoon => '设置页面即将推出';

  @override
  String get logout => '退出登录';

  @override
  String get profile => '个人资料';

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
  String get return_ => '返回';

  @override
  String get ok => '好的';

  @override
  String get accountCreated => '账户创建成功！';

  @override
  String get welcomePlatform => '欢迎使用';

  @override
  String get copyright => '版权所有。© LUC 马来西亚 2025。';
}
