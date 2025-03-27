import 'package:fixiez/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.role,
    required super.isActive,
    required super.balance,
    required super.cashBack,
    required super.accessToken,
    required super.refreshToken,
  });
  factory UserModel.fromSignUpJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      balance: (json['balance'] ?? 0).toDouble(),
      cashBack: (json['cashBack'] ?? 0).toDouble(),
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
  factory UserModel.fromLoginJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['_id'],
      name: json['user']['name'],
      phoneNumber: json['user']['phoneNumber'],
      role: json['user']['role'],
      isActive: json['user']['isActive'],
      balance: (json['user']['balance'] as num).toDouble(),
      cashBack: (json['user']['cashBack'] as num).toDouble(),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'isActive': isActive,
      'balance': balance,
      'cashBack': cashBack,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  /// **تحويل `UserModel` إلى `User`**
  User toEntity() {
    return User(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      role: role,
      isActive: isActive,
      balance: balance,
      cashBack: cashBack,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
