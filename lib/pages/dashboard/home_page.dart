import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/models/user.dart';
import 'package:luc/pages/dashboard/admin_dashboard_page.dart';
import 'package:luc/pages/dashboard/lecturer_dashboard_page.dart';
import 'package:luc/pages/dashboard/student_dashboard_page.dart';
import 'package:luc/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    final userRole = authService.currentUser?.role ?? UserRole.student;

    switch (userRole) {
      case UserRole.lecturer:
        return const LecturerDashboardPage();
      case UserRole.admin:
        return const AdminDashboardPage();
      case UserRole.student:
        return const StudentDashboardPage();
    }
  }
}
