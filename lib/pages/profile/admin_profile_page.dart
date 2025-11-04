// lib/pages/admin_profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:luc/models/user.dart';
import 'package:luc/services/data_service.dart';
import 'package:luc/utils/app_theme.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser? user = Provider.of<DataService>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Profile')),
      body: user == null
          ? const Center(child: Text('Loading user data...'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.profileImageProvider,
                    backgroundColor: AppTheme.backgroundColor,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Name'),
                    subtitle: Text(user.name),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('Role'),
                    subtitle: Text(user.role.name[0].toUpperCase() +
                        user.role.name.substring(1)),
                  ),
                  const Divider(),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("More admin details will be shown here."),
                  )),
                ],
              ),
            ),
    );
  }
}
