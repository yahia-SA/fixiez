class ApiEndpoints {
  // auth
  static const String baseUrl = 'http://93.127.202.37:5510';
  static const String login = '/api/auth/login';
  static const String refresh = '/api/auth/refresh';
  static const String register = '/api/auth/register';
  static const String deleteUser = '/api/auth/delete-account';
  static const String validateActiveCode = '/api/auth/validate-active-code';
  static const String sendActiveCode = '/api/auth/send-active-code';
  static const String updatePass = '/api/auth/update-pass';
  static const String sendResetCode = '/api/auth/send-reset-code';
  static const String resetPassword = '/api/auth/reset-password';
  static const String validateResetPassword =
      '/api/auth/validate-reset-password';
  static const String balanceCashBack = '/api/auth/balance-cash-back';
  // felix
  static const String felix = '/api/felix';

  // repair
  static const String repairRequest = '/api/repair-requests';
  static const String repairRequestsUser = '/api/repair-requests/user';
  static const String repairRequestUpated = '/api/repair-requests/status';

  // review
  static const String reviews = '/api/review';
  // Banners
  static const String banners = '/api/banners';

  // Admin Users
  static const String adminUsers = '/api/admin/get-all-users';
  static const String adminUpdateUser = '/api/admin/update-user-role';
  static const String adminDeleteUser = '/api/admin/delete-user';

  // Admin Services
  static const String adminServices = '/api/admin/get-all-repair-services';
  static const String adminUpdateService = '/api/admin/update-repair-service';
  // Admin Banners
  static const String adminBanners = '/api/admin/get-all-banner';
  static const String adminDeleteBanner = '/api/admin/delete-banner';
  static const String adminCreateBanner = '/api/admin/create-banner';
  static const String adminUpdateBanner = '/api/admin/update-banner';
// Admin Repair Requests
  static const String adminRepairRequests = '/api/admin/get-all-repair-requests';
  static const String adminAnalysis = '/api/admin/analysis';
}

class ApiHeaders {
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
}
