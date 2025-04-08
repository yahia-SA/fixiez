import 'package:fixiez/data/models/meta_data_model.dart';
import 'package:fixiez/data/models/repair_request.dart';

class RepairRequestResponse {
  RepairRequestResponse({
     this.status,
     this.message,
     this.data,
  });

  factory RepairRequestResponse.fromJson(Map<String, dynamic> json) {
    return RepairRequestResponse(
      status: json['status'],
      message: json['message'],
      data: RepairRequestData.fromJson(json['data']),
    );
  }
  final String? status;
  final String? message;
  final RepairRequestData? data;
}

class RepairRequestData {
  RepairRequestData({required this.requests, required this.metadata});

  factory RepairRequestData.fromJson(List<dynamic> json) {
    
    return RepairRequestData(
      requests:
          (json[0] as List)
              .map((item) => RepairRequestModel.fromJson(item))
              .toList(),
      metadata: Metadata.fromJson(json[1]),
    );
  }
  final List<RepairRequestModel> requests;
  final Metadata metadata;
}

