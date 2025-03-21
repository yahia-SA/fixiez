import 'package:fixiez/domain/entities/user.dart';

class UserModel {

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.balance,
    required this.cashBack,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
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
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final bool isActive;
  final double balance;
  final double cashBack;
  final String accessToken;
  final String refreshToken;

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
