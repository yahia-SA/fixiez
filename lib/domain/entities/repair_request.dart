import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/domain/entities/metadata.dart';
import 'package:fixiez/domain/entities/services.dart';

class RepairRequest {
  const RepairRequest({
    required this.id,
    required this.location,
    required this.unitNumber,
    required this.description,
    required this.services,
    required this.serviceType,
    required this.date,
    required this.status,
  });
  final String id;
  final String location;
  final String unitNumber;
  final String description;
  final Services services;
  final String serviceType;
  final DateTime date;
  final String status;
  RepairRequest copyWith({required String status}) {
    return RepairRequest(
      id: id,
      location: location,
      unitNumber: unitNumber,
      description: description,
      services: services,
      serviceType: serviceType,
      date: date,
      status: status,
    );
  }

  RepairRequestModel toModel() {
    return RepairRequestModel(
      id: id,
      location: location,
      unitNumber: unitNumber,
      description: description,
      serviceModel: services.toModel(),
      serviceType: serviceType,
      date: date,
      status: status,
    );
  }
}

class RepairData {
  const RepairData({
    required this.status,
    required this.message,
    required this.requests,
    required this.metadata,
  });

  final String status;
  final String message;
  final List<RepairRequest> requests;
  final MetadataEntity metadata;
  RepairData copyWith({
    String? status,
    String? message,
    List<RepairRequest>? requests,
    MetadataEntity? metadata,
  }) {
    {
      return RepairData(
        status: status ?? this.status,
        message: message ?? this.message,
        requests: requests ?? this.requests,
        metadata: metadata ?? this.metadata,
      );
    }
  }

  RepairDataModel toModel() {
    return RepairDataModel(
      status: status,
      message: message,
      requests: requests.map((e) => e.toModel()).toList(),
      metadata: metadata.toModel(),
    );
  }
}
