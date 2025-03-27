import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/domain/entities/repair_request.dart';

abstract class RepairRepository {
  Future<void> repairRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  });
    Future<RepairData> getRepairRequests({
    required int pageIndex,
  });
}
