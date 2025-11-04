import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luc/utils/app_assets.dart';
import 'package:luc/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _exitController;

  late Animation<double> _scaleAnimation;
  late Animation<Offset> _logoEntrySlide;
  late Animation<Offset> _textEntrySlide;
  late Animation<Offset> _logoExitSlide;
  late Animation<Offset> _textExitSlide;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeInOut),
    );

    _logoEntrySlide =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.1, 0)).animate(
            CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    _textEntrySlide =
        Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(
            CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    _logoExitSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0),
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn));

    _textExitSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    try {
      await _entryController.forward().orCancel;
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        await _exitController.forward().orCancel;
      }
    } on TickerCanceled {
      // Catch the TickerCanceled error which is expected if the widget is
      // disposed of mid-animation (e.g., auth check finishes early).
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              const Color(0xFF160201), // Darker shade for the gradient
            ],
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedBuilder(
              animation: Listenable.merge([_entryController, _exitController]),
              builder: (context, child) {
                final logoPosition = _logoExitSlide.value == Offset.zero
                    ? _logoEntrySlide
                    : _logoExitSlide;
                final textPosition = _textExitSlide.value == Offset.zero
                    ? _textEntrySlide
                    : _textExitSlide;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SlideTransition(
                      position: logoPosition,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child:
                            Image.asset(AppAssets.splashLogoIcon, height: 180),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SlideTransition(
                      position: textPosition,
                      child: Opacity(
                        opacity: _entryController.value,
                        child:
                            Image.asset(AppAssets.splashLogoText, height: 120),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
