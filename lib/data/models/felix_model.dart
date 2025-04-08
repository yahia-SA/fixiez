import 'package:fixiez/domain/entities/felix.dart';

class FelixResponse {

  FelixResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FelixResponse.fromJson(Map<String, dynamic> json) {
    return FelixResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => Felix.fromJson(item))
          .toList(),
    );
  }
  final String status;
  final String message;
  final List<Felix> data;

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Felix {

  Felix({
    required this.id,
    required this.felixNumber,
    required this.cost,
    required this.v,
  });

  factory Felix.fromJson(Map<String, dynamic> json) {
    return Felix(
      id: json['_id'],
      felixNumber: json['felixNumber'],
      cost: json['cost'].toDouble(),
      v: json['__v'],
    );
  }
  final String id;
  final int felixNumber;
  final double cost;
  final int v;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'felixNumber': felixNumber,
    'cost': cost,
    '__v': v,
  };
  FelixEntity toEntity() {
    return FelixEntity(
      id: id,
      felixNumber: felixNumber,
      cost: cost,
      v: v,
    );
  }
}