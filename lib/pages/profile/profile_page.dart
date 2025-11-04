import 'package:flutter/material.dart';
import 'package:luc/pages/profile/admin_profile_page.dart';
import 'package:luc/pages/profile/lecturer_profile_page.dart';
import 'package:luc/pages/profile/student_profile_page.dart';
import 'package:provider/provider.dart';
import 'package:luc/models/user.dart';
import 'package:luc/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userRole = authService.currentUser?.role ?? UserRole.student;

    switch (userRole) {
      case UserRole.lecturer:
        return const LecturerProfilePage();
      case UserRole.admin:
        return const AdminProfilePage();
      case UserRole.student:
        return const StudentProfilePage();
    }
  }
}
