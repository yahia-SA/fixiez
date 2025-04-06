import 'package:fixiez/data/models/meta_data_model.dart';
import 'package:fixiez/data/models/user_model.dart';

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

