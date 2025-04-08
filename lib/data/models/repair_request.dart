import 'package:fixiez/data/models/meta_data_model.dart';
import 'package:fixiez/data/models/service_model.dart';
import 'package:fixiez/data/models/user_model.dart';
import 'package:fixiez/domain/entities/repair_request.dart';

class RepairRequestModel {
  factory RepairRequestModel.fromJson(Map<String, dynamic> json) {
    return RepairRequestModel(
      id: json['_id'],
      location: json['location'],
      unitNumber: json['unitNumber'],
      description: json['description'],
      serviceModel: ServiceModel.fromJson(json['repairServiceId']),
      serviceType: json['serviceType'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      user: UserModel.fromJson(json['userId']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  const RepairRequestModel({
    required this.id,
    required this.location,
    required this.unitNumber,
    required this.description,
    required this.serviceModel,
    required this.serviceType,
    required this.date,
    required this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
  });
  final String id;
  final String location;
  final String unitNumber;
  final String description;
  final ServiceModel serviceModel;
  final String serviceType;
  final DateTime date;
  final String status;
  final UserModel? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RepairRequest toEntity() {
    return RepairRequest(
      id: id,
      location: location,
      unitNumber: unitNumber,
      description: description,
      services: serviceModel.toEntity(),
      serviceType: serviceType,
      date: date,
      status: status,
      user: user?.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  RepairRequestModel copyWith({
    String? id,
    String? location,
    String? unitNumber,
    String? description,
    ServiceModel? serviceModel,
    String? serviceType,
    DateTime? date,
    String? status,
    UserModel? user,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RepairRequestModel(
      id: id ?? this.id,
      location: location ?? this.location,
      unitNumber: unitNumber ?? this.unitNumber,
      description: description ?? this.description,
      serviceModel: serviceModel ?? this.serviceModel,
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}

class RepairDataModel {
  factory RepairDataModel.fromJson(Map<String, dynamic> json) {
    return RepairDataModel(
      status: json['status'],
      message: json['message'],
      requests:
          (json['data'] as List)
              .map((e) => RepairRequestModel.fromJson(e))
              .toList(),
      metadata: Metadata.fromJson(json['metadata']),
    );
  }
  RepairDataModel({this.status, this.message, this.requests, this.metadata});
  String? status;
  String? message;
  List<RepairRequestModel>? requests;
  Metadata? metadata;

  RepairData toEntity() {
    return RepairData(
      status: status!,
      message: message!,
      requests: requests!.map((e) => e.toEntity()).toList(),
      metadata: metadata!.toEntity(),
    );
  }
}
