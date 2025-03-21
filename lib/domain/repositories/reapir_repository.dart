import 'package:fixiez/core/constants/enums.dart';

abstract class RepairRepository {
  Future<void> reapirRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  });
}
