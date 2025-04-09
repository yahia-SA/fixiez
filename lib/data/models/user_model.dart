import 'package:fixiez/domain/entities/user.dart';

class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      isActive: json['isActive'],
      balance: (json['balance'] as num).toDouble(),
      cashBack: (json['cashBack'] as num).toDouble(),
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

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? role,
    bool? isActive,
    double? balance,
    double? cashBack,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      balance: balance ?? this.balance,
      cashBack: cashBack ?? this.cashBack,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
