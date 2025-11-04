// lib/pages/placeholder_page.dart

import 'package:flutter/material.dart';
import 'package:luc/widgets/app_shell.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  final int navIndex;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.navIndex,
  });

  @override
  Widget build(BuildContext context) {
    // We wrap this placeholder in our AppShell to keep the UI consistent
    return AppShell(
      selectedIndex: navIndex,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'This page is coming soon.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
