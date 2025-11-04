// lib/services/auth_service.dart

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:luc/api/api_constants.dart';
import 'package:luc/models/user.dart';

// NOTE: We NO LONGER import the navigator_key here.

enum AuthStatus { uninitialized, authenticated, unauthenticated }

class AuthService extends ChangeNotifier {
  static const _tokenKey = 'authToken';
  static const _timestampKey = 'loginTimestamp';

  String? _authToken;
  AppUser? _currentUser;
  AuthStatus _authStatus = AuthStatus.uninitialized;

  String? get token => _authToken;
  AppUser? get currentUser => _currentUser;
  AuthStatus get authStatus => _authStatus;
  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;

  Future<void> init() async {
    await _loadTokenFromStorage();
  }

  Future<void> _loadTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString(_tokenKey);
    final timestamp = prefs.getInt(_timestampKey);

    if (_authToken != null && timestamp != null) {
      final loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      if (DateTime.now().difference(loginTime).inHours > 24) {
        await logout(); // This simple call is correct
      } else {
        _decodeAndSetUser(_authToken!);
        _authStatus = AuthStatus.authenticated;
      }
    } else {
      _authStatus = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    if (kDebugMode) print('🚀 [AUTH] Login process started for $email');

    final response = await http
        .post(
          Uri.parse(ApiConstants.login),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(const Duration(seconds: 20));

    if (kDebugMode) {
      print('📥 [AUTH] Server response received: ${response.statusCode}');
      print('   => Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody['data'] == null ||
          responseBody['data']['authtoken'] == null) {
        final errorMessage = responseBody['data']?['msg'] ??
            'Invalid credentials, please try again.';
        throw Exception(errorMessage);
      }

      final token = responseBody['data']['authtoken'] as String;

      _authToken = token;
      _decodeAndSetUser(token);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);

      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      if (kDebugMode) print('🎉 [AUTH] LOGIN SUCCESSFUL!');
    } else {
      final errorBody = json.decode(response.body);
      final errorMessage = errorBody['message'] ?? 'Invalid email or password.';
      throw Exception(errorMessage);
    }
  }

  // --- THIS IS THE ORIGINAL, CORRECT, NON-NAVIGATING LOGOUT METHOD ---
  Future<void> logout() async {
    if (kDebugMode) print('🚀 [AUTH] State Logout process started...');

    try {
      _authToken = null;
      _currentUser = null;
      _authStatus = AuthStatus.unauthenticated;
      if (kDebugMode) print('   - Local state and token cleared.');

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_timestampKey);
      if (kDebugMode)
        print('   - Persistent storage (SharedPreferences) cleared.');
    } catch (e) {
      if (kDebugMode) print('❌ [AUTH] An error occurred during logout: $e');
      _authStatus = AuthStatus.unauthenticated;
    } finally {
      if (kDebugMode) print('🔔 [AUTH] Notifying listeners of state change.');
      notifyListeners();
    }
  }
  // --------------------------------------------------------------------

  void _decodeAndSetUser(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) throw Exception('Invalid token');

      final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

      String? imageUrl;
      Uint8List? imageBytes;
      final rawProfilePic = payload['profilepic'] as String?;

      if (rawProfilePic != null && rawProfilePic.isNotEmpty) {
        if (rawProfilePic.startsWith('data:image')) {
          imageBytes = base64Decode(rawProfilePic.split(',').last);
        } else if (rawProfilePic.startsWith('http')) {
          imageUrl = rawProfilePic;
        }
      }

      _currentUser = AppUser(
        uid: payload['userId']?.toString() ?? '',
        name: payload['username']?.toString() ?? 'User',
        email: payload['email']?.toString() ?? '',
        role: _roleFromString(payload['role']),
        profileImageUrl: imageUrl,
        profileImageBytes: imageBytes,
      );
    } catch (e) {
      print("❌ Failed to decode token: $e");
      logout();
    }
  }

  static UserRole _roleFromString(dynamic role) {
    if (role is List && (role.contains('admin') || role.contains('ADMIN'))) {
      return UserRole.admin;
    }
    if (role is List &&
        (role.contains('lecturer') || role.contains('LECTURER'))) {
      return UserRole.lecturer;
    }
    if (role is String) {
      switch (role.toLowerCase()) {
        case 'admin':
          return UserRole.admin;
        case 'lecturer':
          return UserRole.lecturer;
      }
    }
    return UserRole.student;
  }

  void updateCurrentUserDetails(Map<String, dynamic> profileData) {
    if (_currentUser == null) return;
    _currentUser = AppUser(
      uid: _currentUser!.uid,
      email: profileData['email'] ?? _currentUser!.email,
      name: profileData['name'] ?? _currentUser!.name,
      role: _roleFromString(profileData['role'] ?? _currentUser!.role.name),
      profileImageUrl:
          profileData['profileImageUrl'] ?? _currentUser!.profileImageUrl,
    );
    notifyListeners();
  }
}
