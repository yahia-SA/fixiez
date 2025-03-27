import 'package:equatable/equatable.dart';

class RepairRequest extends Equatable {
  const RepairRequest({
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

  @override
  List<Object?> get props => [
    id,
    location,
    unitNumber,
    description,
    serviceId,
    serviceName,
    serviceCost,
    serviceType,
    date,
    status,
  ];
}
class RepairData extends Equatable {
  const RepairData({required this.status, required this.message, required this.requests, required this.totalItems, required this.totalPages});

  final String status;
  final String message;
  final List<RepairRequest> requests;
  final int totalItems;
  final int totalPages;

  @override
  List<Object?> get props => [status, message, requests, totalItems, totalPages];

}
