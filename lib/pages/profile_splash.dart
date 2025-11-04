import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/services/auth_service.dart';
import 'package:luc/utils/app_assets.dart';
import 'package:luc/utils/app_theme.dart';
import 'package:luc/pages/dashboard/home_page.dart'; // <-- ADD THIS IMPORT

class ProfileSplash extends StatefulWidget {
  const ProfileSplash({super.key});

  @override
  State<ProfileSplash> createState() => _ProfileSplashState();
}

class _ProfileSplashState extends State<ProfileSplash> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Center(
            child: Text("Error: User not found.",
                style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.lucLogo, height: 100),
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundImage: user.profileImageProvider,
              backgroundColor: AppTheme.backgroundColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome, ${user.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${user.uid}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
