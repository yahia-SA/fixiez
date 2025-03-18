class ApiEndpoints {
  static const String baseUrl = 'https://fixiez-backend.onrender.com/api/v1';
  static const String signup = 'users/signup';
  static const String forgotPassword = 'users/forgotPassword';
  static const String login = 'users/login';
  static const String posts = 'posts';
  static const String contactUs = 'users/contact-us';
  static const String profile = 'users/me';
  static const String update = 'users/updateMe';
  static const String updatePassword = 'users/updateMyPassword';
}

class ApiHeaders {
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  
}