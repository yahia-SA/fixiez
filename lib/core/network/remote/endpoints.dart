class ApiEndpoints {
  // auth
  static const String baseUrl = 'http://93.127.202.37:5510/api';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String register = '/auth/register';
  static const String validateActiveCode = '/auth/validate-active-code';
  static const String sendActiveCode = '/auth/send-active-code';
  static const String updatePass = '/auth/update-pass';
  static const String sendResetCode = '/auth/send-reset-code';
  static const String resetPassword = '/auth/reset-password';
  static const String validateResetPassword = '/auth/validate-reset-password';
  static const String balanceCashBack = '/auth/balance-cash-back';

  // repair
  static const String repairRequest = '/repair-requests';
  

  // Banners
  static const String banners = '/banners';
}

class ApiHeaders {
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
}
