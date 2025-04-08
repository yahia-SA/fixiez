import 'package:fixiez/domain/entities/services.dart';

class ServiceResponseModel {
  ServiceResponseModel({required this.status, required this.data});

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      status: json['status'],
      data:
          (json['data'] as List)
              .map((item) => ServiceModel.fromJson(item))
              .toList(),
    );
  }
  final String status;
  final List<ServiceModel> data;
}

class ServiceModel {
  ServiceModel({
    this.id,
    this.name,
    this.cost,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      name: json['name'],
      cost: json['cost'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }
  final String? id;
  final String? name;
  final int? cost;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  Services toEntity() {
    return Services(id: id!, name: name!, cost: cost!);
  }
}
