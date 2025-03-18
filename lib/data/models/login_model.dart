class LoginModel {

  LoginModel({required this.phone, required this.password});
  final String phone;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}
