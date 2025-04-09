import 'package:fixiez/data/models/meta_data_model.dart';
import 'package:fixiez/domain/entities/felix.dart';

class FelixResponse {
  FelixResponse({this.status, this.message, this.data, this.metadata});

  factory FelixResponse.fromJson(Map<String, dynamic> json) {
    return FelixResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List).map((item) => Felix.fromJson(item)).toList(),
      metadata:
          json['metadata'] != null
              ? Metadata.fromJson(json['metadata'] as Map<String, dynamic>)
              : null,
    );
  }
  final String? status;
  final String? message;
  final List<Felix>? data;
  Metadata? metadata;

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': (data?.map((x) => x.toJson())),
    'metadata': metadata?.toJson(),
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
    return FelixEntity(id: id, felixNumber: felixNumber, cost: cost, v: v);
  }

  Felix copyWith({String? id, int? felixNumber, double? cost, int? v}) {
    return Felix(
      id: id ?? this.id,
      felixNumber: felixNumber ?? this.felixNumber,
      cost: cost ?? this.cost,
      v: v ?? this.v,
    );
  }
}
