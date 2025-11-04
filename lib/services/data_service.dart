import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luc/api/api_constants.dart';
import 'package:luc/models/user.dart';
import 'package:luc/services/auth_service.dart';

enum DataStatus { initial, loading, loaded, error }

class DataService extends ChangeNotifier {
  AuthService _authService;

  Map<String, dynamic>? _userProfileData;
  AppUser? get user => _authService.currentUser;
  Map<String, dynamic>? get userProfileData => _userProfileData;

  DataStatus _status = DataStatus.initial;
  String _errorMessage = '';

  DataStatus get status => _status;
  String get errorMessage => _errorMessage;

  DataService(this._authService);

  // --- THIS IS THE UPDATED, "SMART" METHOD ---
  // This is called by the ChangeNotifierProxyProvider in main.dart whenever
  // the AuthService changes.
  void updateAuthService(AuthService newAuthService) {
    // Check if the user's state has transitioned from logged-in to logged-out.
    if (_authService.isAuthenticated && !newAuthService.isAuthenticated) {
      if (kDebugMode) {
        print('🔄 [DATA] Logout detected. Clearing user data.');
      }
      // If a logout occurred, automatically clear the data.
      clearData();
    }

    // Finally, update the internal reference to the latest AuthService instance.
    _authService = newAuthService;
  }
  // ---------------------------------------------

  Future<void> fetchAndSetUserData() async {
    if (!_authService.isAuthenticated) {
      if (kDebugMode) {
        print('⚠️ [DATA] Fetch aborted. User is not authenticated.');
      }
      return;
    }

    // Prevent re-fetching if data is already loading or loaded.
    if (_status == DataStatus.loading || _status == DataStatus.loaded) return;

    _status = DataStatus.loading;
    notifyListeners();

    try {
      if (kDebugMode) print('⏳ [DATA] Fetching user profile...');
      _userProfileData = await _fetchUserProfile();

      if (_userProfileData != null) {
        _authService.updateCurrentUserDetails(_userProfileData!);
      }
      _status = DataStatus.loaded;
      if (kDebugMode) print('✅ [DATA] User profile loaded successfully.');
    } catch (e) {
      _status = DataStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (kDebugMode) print('❌ [DATA] Failed to fetch profile: $_errorMessage');
    } finally {
      if (hasListeners) {
        notifyListeners();
      }
    }
  }

  void clearData() {
    _userProfileData = null;
    _status = DataStatus.initial;
    _errorMessage = '';
    notifyListeners();
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final response = await http.get(
      Uri.parse(ApiConstants.userProfile),
      headers: {'Authorization': 'Bearer ${_authService.token}'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
