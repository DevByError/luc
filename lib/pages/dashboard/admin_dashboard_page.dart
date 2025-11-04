// lib/pages/admin_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:luc/widgets/app_shell.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The admin dashboard also uses the AppShell
    return AppShell(
      selectedIndex: 0, // 'Home' is the first item
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              'Admin Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Admin-specific content will be displayed here.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
