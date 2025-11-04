// lib/models/user.dart

import 'dart:typed_data'; // Required for Uint8List
import 'package:flutter/material.dart';
import 'package:luc/utils/app_assets.dart';

enum UserRole { student, lecturer, admin }

class AppUser {
  final String uid;
  final String name;
  final String email;

  // Can hold EITHER a URL OR the raw image bytes
  final String? profileImageUrl;
  final Uint8List? profileImageBytes;

  final UserRole role;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.profileImageBytes, // New field
    this.role = UserRole.student,
  });

  /// --- THE REUSABLE VARIABLE ---
  /// This smart getter provides the correct ImageProvider for the UI.
  /// Widgets don't need to know if the image is from the network, assets, or memory.
  ImageProvider get profileImageProvider {
    // Priority 1: If we have decoded image bytes, use them.
    if (profileImageBytes != null) {
      return MemoryImage(profileImageBytes!);
    }
    // Priority 2: If we have a URL, use it.
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return NetworkImage(profileImageUrl!);
    }
    // Priority 3: Fallback to the default asset image.
    return const AssetImage(AppAssets.defaultProfile);
  }
}
