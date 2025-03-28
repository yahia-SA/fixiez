import 'package:fixiez/data/models/meta_data_model.dart';

class ReviewsModel {
  ReviewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  ReviewsModel({this.status, this.message, this.data, this.metadata});
  String? status;
  String? message;
  List<Data>? data;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Data {
  Data({this.sId, this.userId, this.comment, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? sId;
  UserId? userId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class UserId {
  UserId({
    this.sId,
    this.name,
    this.password,
    this.phoneNumber,
    this.role,
    this.isActive,
    this.balance,
    this.cashBack,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    isActive = json['isActive'];
    balance = json['balance'];
    cashBack = json['cashBack'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
  String? sId;
  String? name;
  String? password;
  String? phoneNumber;
  String? role;
  bool? isActive;
  int? balance;
  int? cashBack;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['isActive'] = isActive;
    data['balance'] = balance;
    data['cashBack'] = cashBack;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
