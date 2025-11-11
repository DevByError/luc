import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:luc/firebase_options.dart';
import 'package:luc/models/message.dart';

// Page Imports
import 'package:luc/pages/language_page.dart';
import 'package:luc/pages/login_page.dart';
import 'package:luc/pages/placeholder_page.dart';
import 'package:luc/pages/detail_placeholder_page.dart';
import 'package:luc/pages/dashboard/home_page.dart';
import 'package:luc/pages/dashboard/admin_dashboard_page.dart';
import 'package:luc/pages/dashboard/student_dashboard_page.dart';
import 'package:luc/pages/dashboard/lecturer_dashboard_page.dart';
import 'package:luc/pages/profile/profile_page.dart';
import 'package:luc/pages/profile/student_profile_page.dart';
import 'package:luc/pages/profile/lecturer_profile_page.dart';
import 'package:luc/pages/profile/admin_profile_page.dart';

//student pages imports
import 'package:luc/pages/dashboard/student_pages/my_program_page.dart';
import 'package:luc/pages/dashboard/student_pages/exam_result_page.dart';
import 'package:luc/pages/dashboard/student_pages/fees_page.dart';
import 'package:luc/pages/dashboard/student_pages/exam_slip_page.dart';
import 'package:luc/pages/dashboard/student_pages/attendance_page.dart';

// Service Imports
import 'package:luc/services/auth_service.dart';
import 'package:luc/services/data_service.dart';

// Utility and Gate Imports
import 'package:luc/utils/app_theme.dart';
import 'package:luc/widgets/auth_gate.dart';
import 'package:luc/widgets/auth_listener.dart';

// Localization
import 'package:flutter_localizations/flutter_localizations.dart';

// Chatbot Imports
import 'package:luc/pages/chatbot_page.dart';
import 'package:luc/services/chatbot_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());

  final authService = AuthService();

  await authService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authService),
        ChangeNotifierProxyProvider<AuthService, DataService>(
          create: (context) =>
              DataService(Provider.of<AuthService>(context, listen: false)),
          update: (context, auth, previous) =>
              previous!..updateAuthService(auth),
        ),
        ChangeNotifierProvider(create: (_) => ChatbotService()),
      ],
      child: const LucApp(),
    ),
  );
}

class LucApp extends StatelessWidget {
  const LucApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthListener(
        child: MaterialApp(
      title: 'Luc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      supportedLocales: const [
        Locale('en'),
        Locale('ms'),
        Locale('ar'),
        Locale('bn'),
        Locale('zh'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AuthGate(),
      routes: {
        '/language': (context) => const LanguagePage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/student_dashboard': (context) => const StudentDashboardPage(),
        '/lecturer_dashboard': (context) => const LecturerDashboardPage(),
        '/admin_dashboard': (context) => const AdminDashboardPage(),
        '/student_profile': (context) => const StudentProfilePage(),
        '/lecturer_profile': (context) => const LecturerProfilePage(),
        '/admin_profile': (context) => const AdminProfilePage(),
        '/chat': (context) => const PlaceholderPage(title: 'Chat', navIndex: 1),
        '/notifications': (context) =>
            const PlaceholderPage(title: 'Notifications', navIndex: 2),
        '/classes': (context) =>
            const PlaceholderPage(title: 'Classes', navIndex: 3),
        '/my_program': (context) => const MyProgramPage(),
        '/subject_register': (context) =>
            const DetailPlaceholderPage(title: 'Subject Registration'),
        '/schedule': (context) =>
            const DetailPlaceholderPage(title: 'Schedule'),
        '/materials': (context) =>
            const DetailPlaceholderPage(title: 'Study Materials'),
        '/assignment': (context) =>
            const DetailPlaceholderPage(title: 'Assignment'),
        '/attendance': (context) => const AttendancePage(),
        '/exam_slip': (context) => const ExamSlipPage(),
        '/exam_result': (context) => const ExamResultPage(),
        '/fees': (context) => const FeesPage(),
        '/chatbot': (context) => const ChatbotPage(),
      },
    ));
  }
}
