// lib/pages/student_dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:luc/utils/app_theme.dart';
import 'package:luc/widgets/app_shell.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedIndex: 0,
      child: _buildMainContent(context),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final List<Map<String, Object>> menuItems = [
      {
        'title': 'My Program',
        'icon': Icons.school_outlined,
        'route': '/my_program'
      },
      {
        'title': 'Subject\nRegister',
        'icon': Icons.book_outlined,
        'route': '/subject_register'
      },
      {
        'title': 'Schedule',
        'icon': Icons.calendar_today_outlined,
        'route': '/schedule'
      },
      {
        'title': 'Study Materials',
        'icon': Icons.menu_book,
        'route': '/materials'
      },
      {
        'title': 'Assignment',
        'icon': Icons.assignment_outlined,
        'route': '/assignment'
      },
      {
        'title': 'Attendance',
        'icon': Icons.fact_check_outlined,
        'route': '/attendance'
      },
      {
        'title': 'Exam Slip',
        'icon': Icons.sticky_note_2_outlined,
        'route': '/exam_slip'
      },
      {
        'title': 'Exam Result',
        'icon': Icons.bar_chart_outlined,
        'route': '/exam_result'
      },
      {
        'title': 'Fee Payments',
        'icon': Icons.payment_outlined,
        'route': '/fees'
      },
    ];

    return SingleChildScrollView(
      // Use physics that feel natural
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- UI FIX 1: SEARCH BAR ---
          // The TextField is now styled to match your image.
          TextField(
            style:
                const TextStyle(color: Colors.white), // Makes typing text white
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              filled: true,
              fillColor: AppTheme.primaryColor, // Use the dark red theme color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          // -----------------------------
          const SizedBox(height: 20),

          // Upcoming Events
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "Upcoming Events: Coming Soon",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Visa Status Card
          GestureDetector(
            onTap: () {/* Navigate to Visa Page */},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Visa Status',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 9-Button Grid
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: menuItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return _MenuGridCard(
                title: item['title'] as String,
                icon: item['icon'] as IconData,
                onTap: () =>
                    Navigator.pushNamed(context, item['route'] as String),
              );
            },
          ),
          // Add space at the bottom to ensure content isn't hidden by the FAB
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// Helper widget for the grid items
class _MenuGridCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _MenuGridCard(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      // --- UI FIX 2: GRID BUTTONS ---
      // Changed from default Card color to a specific light pink/white
      color: const Color(0xFFFFF5F5),
      elevation: 2,
      shadowColor: Colors.red.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // -------------------------------
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              // Use primaryText color for better contrast and alignment with your theme
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}
