// lib/pages/student_profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/services/data_service.dart';
import 'package:luc/utils/app_theme.dart';
import 'package:luc/models/user.dart';

// NOTE: The EditContactDialog is not included here as it would be a large
// amount of code duplication. It should be moved to its own file in `widgets/`
// to be reusable, but for now, we will just have the buttons.

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer will automatically rebuild when data changes
    return Consumer<DataService>(
      builder: (context, dataService, child) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildResponsiveAppBar(context),
              _buildBody(context, dataService),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DataService dataService) {
    switch (dataService.status) {
      case DataStatus.loading:
      case DataStatus.initial:
        return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()));
      case DataStatus.error:
        return SliverFillRemaining(
            child: Center(child: Text(dataService.errorMessage)));
      case DataStatus.loaded:
        final user = dataService.user;
        final profileData =
            dataService.userProfileData ?? {}; // Use the detailed data
        if (user == null) {
          return const SliverFillRemaining(
              child: Center(child: Text("User data not available.")));
        }
        return SliverToBoxAdapter(
          child: _buildProfileContent(context, user, profileData),
        );
    }
  }

  Widget _buildResponsiveAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.primaryText),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Profile',
          style: TextStyle(
              color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
      centerTitle: true,
    );
  }

  Widget _buildProfileContent(
      BuildContext context, AppUser user, Map<String, dynamic> profileData) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProfileHeader(context, user, profileData, screenWidth),
          const SizedBox(height: 24),
          _buildInfoGrid(context, profileData, screenWidth),
          const SizedBox(height: 24),
          _buildContactSection(context, profileData, screenWidth),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, AppUser user,
      Map<String, dynamic> profileData, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: user.profileImageProvider,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Student ID: ${profileData['studentId'] ?? 'N/A'}',
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 4),
                Text(profileData['course'] ?? 'N/A',
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(
      BuildContext context, Map<String, dynamic> data, double screenWidth) {
    final items = [
      {'title': 'Intake', 'value': data['intake'], 'icon': Icons.school},
      {
        'title': 'Academic Year',
        'value': data['academicYear'],
        'icon': Icons.calendar_today
      },
      {'title': 'Semester', 'value': data['semester'], 'icon': Icons.bookmark},
      {
        'title': 'Date of Birth',
        'value': data['dateOfBirth'],
        'icon': Icons.cake
      },
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _InfoTile(
          title: item['title'] as String,
          value: item['value']?.toString() ?? 'N/A',
          icon: item['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildContactSection(
      BuildContext context, Map<String, dynamic> data, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _ContactRow(
          title: 'Phone Number',
          value: data['phone'] ?? 'N/A',
          icon: Icons.phone,
          onEdit: () {/* Show Edit Dialog */},
        ),
        _ContactRow(
          title: 'Email Address',
          value: data['email'] ?? 'N/A',
          icon: Icons.email,
          onEdit: () {/* Show Edit Dialog */},
        ),
        _ContactRow(
          title: 'Residence Address',
          value: data['address'] ?? 'N/A',
          icon: Icons.home,
          onEdit: () {/* Show Edit Dialog */},
        ),
      ],
    );
  }
}

// --- Reusable UI Components for Student Profile ---

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoTile(
      {required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                      fontWeight: FontWeight.w600)),
              Icon(icon, size: 16, color: AppTheme.primaryColor),
            ],
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText)),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onEdit;

  const _ContactRow(
      {required this.title,
      required this.value,
      required this.icon,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title,
            style:
                const TextStyle(fontSize: 12, color: AppTheme.secondaryText)),
        subtitle: Text(value,
            style: const TextStyle(
                fontSize: 16,
                color: AppTheme.primaryText,
                fontWeight: FontWeight.w500)),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppTheme.secondaryText),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
