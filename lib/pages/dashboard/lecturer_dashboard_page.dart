// lib/pages/lecturer_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:luc/widgets/app_shell.dart';

class LecturerDashboardPage extends StatelessWidget {
  const LecturerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The lecturer dashboard also uses the AppShell
    return AppShell(
      selectedIndex: 0, // 'Home' is the first item
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              'Lecturer Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Lecturer-specific content will be displayed here.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
