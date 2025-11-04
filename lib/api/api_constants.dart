class ApiConstants {
  static const String baseUrl =
      "https://api.techvisionsoft.com"; // Replace with your server URL

  // Auth
  static const String login = "$baseUrl/login";

  // User
  static const String userProfile = "$baseUrl/user/profile";
  static const String updateUser = "$baseUrl/user/update";
  static const String requestOtp = "$baseUrl/user/request-otp";

  static const String userClasses = "$baseUrl/user/classes";
}
