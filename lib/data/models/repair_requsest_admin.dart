import 'package:fixiez/data/models/meta_data_model.dart';
import 'package:fixiez/data/models/service_model.dart';
import 'package:fixiez/data/models/user_model.dart';

class RepairRequestResponse {
  RepairRequestResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RepairRequestResponse.fromJson(Map<String, dynamic> json) {
    return RepairRequestResponse(
      status: json['status'],
      message: json['message'],
      data: RepairRequestData.fromJson(json['data']),
    );
  }
  final String status;
  final String message;
  final RepairRequestData data;
}

class RepairRequestData {
  RepairRequestData({required this.requests, required this.metadata});

  factory RepairRequestData.fromJson(List<dynamic> json) {
    return RepairRequestData(
      requests:
          (json[0] as List)
              .map((item) => RepairRequest.fromJson(item))
              .toList(),
      metadata: Metadata.fromJson(json[1]),
    );
  }
  final List<RepairRequest> requests;
  final Metadata metadata;
}

class RepairRequest {
  RepairRequest({
    required this.id,
    required this.location,
    required this.unitNumber,
    required this.description,
    required this.serviceModel,
    required this.serviceType,
    required this.date,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RepairRequest.fromJson(Map<String, dynamic> json) {
    return RepairRequest(
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
  final String id;
  final String location;
  final String unitNumber;
  final String description;
  final ServiceModel serviceModel;
  final String serviceType;
  final DateTime date;
  final String status;
  final UserModel user;
  final DateTime createdAt;
  final DateTime updatedAt;
}
