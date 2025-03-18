import 'package:fixiez/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['user']['_id'],
      name: json['data']['user']['name'],
      phoneNumber: json['data']['user']['phoneNumber'],
      role: json['data']['user']['role'],
      isActive: json['data']['user']['isActive'],
      balance: (json['data']['user']['balance'] as num).toDouble(),
      cashBack: (json['data']['user']['cashBack'] as num).toDouble(),
      accessToken: json['data']['accessToken'],
      refreshToken: json['data']['refreshToken'],
    );
  }
}
