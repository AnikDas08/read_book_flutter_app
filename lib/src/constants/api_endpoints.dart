class ApiEndpoints {
  static const String baseUrl = 'http://10.10.7.65:5006/api/v1';
  static const String imageBaseUrl = 'http://10.10.7.65:5006';

  // Authentication endpoints
  static const String login = '$baseUrl/auth/login';
  static const String signup = '$baseUrl/users/create';
  static const String logout = '$baseUrl/auth/logout';
  static const String sendOtp = '$baseUrl/auth/forgot-password-otp';
  static const String verifyOtp = '$baseUrl/users/verify-otp';
  static const String createPassword = '$baseUrl/auth/forgot-password-reset';
  static const String checkAuth = '$baseUrl/auth/check';

  // Profile endpoints
  static const String getProfile = '$baseUrl/profile';
  static const String updateProfile = '$baseUrl/profile';
  static const String changePassword = '$baseUrl/profile/change-password';

  // Book endpoints
  static const String getBooks = '$baseUrl/book/user';
  static String bookDetails = '$baseUrl/book/';
  static String chapters = '$baseUrl/chapter/book/';

  static const String refreshToken = '$baseUrl/auth/refresh-token';
}
