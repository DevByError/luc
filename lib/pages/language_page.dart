import 'package:flutter/material.dart';
import 'package:luc/utils/app_assets.dart';
import 'package:luc/utils/app_theme.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});
  // TODO: Add a callback to save the selected locale globally
  // final void Function(Locale) onLocaleChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reusing the AppAssets variable for the logo
                Image.asset(AppAssets.lucLogo, height: 180),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    // Reusing AppTheme colors
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Choose Your Language', // TODO: Localize this text
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        // TODO: Localize this text
                        'Welcome to the LUC App. Please choose a language to continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildLangButton(
                        context,
                        label: "🇺🇸 English",
                        locale: const Locale('en'),
                      ),
                      const SizedBox(height: 16),
                      _buildLangButton(
                        context,
                        label: "🇲🇾 Bahasa Melayu",
                        locale: const Locale('ms'),
                      ),
                      const SizedBox(height: 16),
                      _buildLangButton(
                        context,
                        label: "🇸🇦 العربية",
                        locale: const Locale('ar'),
                      ),
                      const SizedBox(height: 16),
                      _buildLangButton(
                        context,
                        label: "🇧🇩 বাংলা",
                        locale: const Locale('bn'),
                      ),
                      const SizedBox(height: 16),
                      _buildLangButton(
                        context,
                        label: "🇨🇳 中文",
                        locale: const Locale('zh'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "All Copyrights Reserved. © LUC Malaysia ${DateTime.now().year}.",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This is a private helper widget, perfect for a UI element that is only
  // used on this page, following our "build once, reuse many" principle.
  Widget _buildLangButton(
    BuildContext context, {
    required String label,
    required Locale locale,
  }) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Here you will call the function to set the app's locale globally
        // For example: onLocaleChange(locale);

        // After setting the locale, navigate to the login page
        Navigator.pushReplacementNamed(context, '/login');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
