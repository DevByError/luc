// lib/widgets/auth_listener.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/services/auth_service.dart';
import 'package:luc/utils/navigator_key.dart';

/// This widget listens to authentication state changes and handles
/// global navigation events, like redirecting to the login screen on logout.
class AuthListener extends StatefulWidget {
  final Widget child;
  const AuthListener({super.key, required this.child});

  @override
  State<AuthListener> createState() => _AuthListenerState();
}

class _AuthListenerState extends State<AuthListener> {
  // We add the listener in initState
  @override
  void initState() {
    super.initState();
    // Start listening as soon as this widget is in the tree
    Provider.of<AuthService>(context, listen: false)
        .addListener(_onAuthChanged);
  }

  // We must remove the listener in dispose to prevent memory leaks
  @override
  void dispose() {
    Provider.of<AuthService>(context, listen: false)
        .removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    final authService = Provider.of<AuthService>(context, listen: false);

    // We only care about the logout event
    if (!authService.isAuthenticated) {
      // Use a post-frame callback to ensure the current build/dispose cycle is complete.
      // This prevents errors when navigating immediately after a state change.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use the global navigator key to safely navigate without a local context.
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/login', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This widget doesn't build any UI itself; it just passes its child through.
    return widget.child;
  }
}
