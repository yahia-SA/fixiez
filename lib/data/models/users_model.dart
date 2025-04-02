import 'package:fixiez/data/models/meta_data_model.dart';

class UsersMdoel {
  UsersMdoel({
    this.status,
    this.message,
    this.data,
    this.metadata,
  });

  factory UsersMdoel.fromJson(Map<String, dynamic> json) => UsersMdoel(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? List<UserModel>.from(
                (json['data'] as List).map((x) => UserModel.fromJson(x)))
            : null,
        metadata: json['metadata'] != null
            ? Metadata.fromJson(json['metadata'] as Map<String, dynamic>)
            : null,
      );

  String? status;
  String? message;
  List<UserModel>? data;
  Metadata? metadata;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'metadata': metadata?.toJson(),
      };
}

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.password,
    this.phoneNumber,
    this.role,
    this.isActive,
    this.balance,
    this.cashBack,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.activeCode,
    this.activeCodeExpiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        password: json['password'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        role: json['role'] as String?,
        isActive: json['isActive'] as bool?,
        balance: json['balance'] as int?,
        cashBack: json['cashBack'] as int?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
        activeCode: json['activeCode'] as String?,
        activeCodeExpiresIn: json['activeCodeExpiresIn'] as String?,
      );

  String? id;
  String? name;
  String? password;
  String? phoneNumber;
  String? role;
  bool? isActive;
  int? balance;
  int? cashBack;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? activeCode;
  String? activeCodeExpiresIn;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'password': password,
        'phoneNumber': phoneNumber,
        'role': role,
        'isActive': isActive,
        'balance': balance,
        'cashBack': cashBack,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
        if (activeCode != null) 'activeCode': activeCode,
        if (activeCodeExpiresIn != null) 'activeCodeExpiresIn': activeCodeExpiresIn,
      };
}