class ApiEndpoints {
  // auth
  static const String baseUrl = 'http://93.127.202.37:5510';
  static const String login = '/api/auth/login';
  static const String refresh = '/api/auth/refresh';
  static const String register = '/api/auth/register';
  static const String validateActiveCode = '/api/auth/validate-active-code';
  static const String sendActiveCode = '/api/auth/send-active-code';
  static const String updatePass = '/api/auth/update-pass';
  static const String sendResetCode = '/api/auth/send-reset-code';
  static const String resetPassword = '/api/auth/reset-password';
  static const String validateResetPassword = '/api/auth/validate-reset-password';
  static const String balanceCashBack = '/api/auth/balance-cash-back';

  // repair
  static const String repairRequest = '/api/repair-requests';
  static const String repairRequestsUser = '/api/repair-requests/user';
  
  // review 
  static const String reviews = '/api/review';
  // Banners
  static const String banners = '/api/banners';

  // Admin
  static const String adminUsers = '/api/admin/get-all-users';
}

class ApiHeaders {
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
}
