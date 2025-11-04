import 'package:flutter/material.dart';
import 'package:luc/pages/dashboard/home_page.dart';
import 'package:provider/provider.dart';
import 'package:luc/services/auth_service.dart';
import 'package:luc/pages/language_page.dart';
import 'package:luc/pages/splash_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isSplashFinished = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      setState(() {
        _isSplashFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSplashFinished) {
      return const SplashScreen();
    }

    return Consumer<AuthService>(
      builder: (context, auth, child) {
        switch (auth.authStatus) {
          case AuthStatus.authenticated:
            return const HomePage();

          case AuthStatus.unauthenticated:
          default:
            return const LanguagePage();
        }
      },
    );
  }
}
