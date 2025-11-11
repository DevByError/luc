/*
class ApiConstants {
  static const String baseUrl =
      "https://api.techvisionsoft.com"; // where the fun begins :)

  // Auth
  static const String login = "$baseUrl/login";
  // User
  static const String userProfile = "$baseUrl/user/profile";
  static const String updateUser = "$baseUrl/user/update";
  static const String requestOtp = "$baseUrl/user/request-otp";

  static const String userClasses = "$baseUrl/user/classes";
}
*/

class ApiConstants {
  // For Android Emulator:
  static const String baseUrl = "http://10.0.2.2:3000/api/auth";

  // For iOS Simulator:
  // static const String baseUrl = "http://localhost:3000/api/auth";

  // For Physical Device (replace with YOUR computer's IP):
  // static const String baseUrl = "http://192.168.1.100:3000/api/auth";

  // Auth
  static const String login = "$baseUrl/login"; // Results in: /api/auth/login ✅

  // User
  static const String userProfile = "http://10.0.2.2:3000/api/user/profile";
  // Note: userProfile is separate because it's /api/user/profile not /api/auth/user/profile

  static const String updateUser = "$baseUrl/update";
  static const String requestOtp = "$baseUrl/request-otp";
  static const String userClasses = "$baseUrl/classes";
}
