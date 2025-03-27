
import 'package:fixiez/domain/entities/repair_request.dart';

class RepairRequestModel {

  factory RepairRequestModel.fromJson(Map<String, dynamic> json) {
    return RepairRequestModel(
      id: json['_id'],
      location: json['location'],
      unitNumber: json['unitNumber'],
      description: json['description'],
      serviceId: json['repairServiceId']['_id'],
      serviceName: json['repairServiceId']['name'],
      serviceCost: (json['repairServiceId']['cost'] as num).toDouble(),
      serviceType: json['serviceType'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }

  const RepairRequestModel({
    required this.id,
    required this.location,
    required this.unitNumber,
    required this.description,
    required this.serviceId,
    required this.serviceName,
    required this.serviceCost,
    required this.serviceType,
    required this.date,
    required this.status,
  });
  final String id;
  final String location;
  final String unitNumber;
  final String description;
  final String serviceId;
  final String serviceName;
  final double serviceCost;
  final String serviceType;
  final DateTime date;
  final String status;
    RepairRequest toEntity() {
    return RepairRequest(
      id: id,
      location: location,
      unitNumber: unitNumber,
      description: description,
      serviceId: serviceId,
      serviceName: serviceName,
      serviceCost: serviceCost,
      serviceType: serviceType,
      date: date,
      status: status,
    );
  }

}
class RepairDataModel  {
  
  factory RepairDataModel.fromJson(Map<String, dynamic> json) {
    return RepairDataModel(
      status: json['status'],
      message: json['message'],
      requests: (json['data'] as List).map((e) => RepairRequestModel.fromJson(e)).toList(),
      totalItems: json['metadata']['totalItems'],
      totalPages: json['metadata']['totalPages'],
    );
  }
  const RepairDataModel({
    required this.status,
    required this.message,
    required this.requests,
    required this.totalItems,
    required this.totalPages,
  });
  final String status;
  final String message;
  final List<RepairRequestModel> requests;
  final int totalItems;
  final int totalPages;
  RepairData toEntity() {
    return RepairData(
      status: status,
      message: message,
      requests: requests.map((e) => e.toEntity()).toList(),
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
  
}