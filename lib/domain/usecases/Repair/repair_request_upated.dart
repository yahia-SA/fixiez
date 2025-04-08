import 'package:fixiez/domain/repositories/repair_repository.dart';

class RepairRequestUpatedUseCase {
  RepairRequestUpatedUseCase(this.repairRepository);

  final RepairRepository repairRepository;

  Future<void> call({required String id, required String status}) async =>
      await repairRepository.repairRequestUpated(id: id, status: status);
}
