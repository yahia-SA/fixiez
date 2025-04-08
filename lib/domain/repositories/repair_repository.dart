import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/data/models/repair_request.dart';

abstract class RepairRepository {
  Future<void> repairRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  });
  Future<RepairDataModel> getRepairRequests({required int pageIndex});

  Future<bool> repairRequestUpated({
    required String id,
    required String status,
  });
}
