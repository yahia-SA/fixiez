import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/domain/repositories/repair_repository.dart';

class RepairRequestUseCase {
  RepairRequestUseCase(this.repairRepository);
  final RepairRepository repairRepository;

  Future<void> call({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  }) async {
    await repairRepository.repairRequest(location: location, unitNumber: unitNumber, description: description, serviceName: serviceName, serviceType: serviceType, date: date);
  }
  
}