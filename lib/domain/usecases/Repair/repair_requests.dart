import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/domain/repositories/repair_repository.dart';

class RepairRequestsUseCase {
  RepairRequestsUseCase(this.repairRepository);
  final RepairRepository repairRepository;

  Future<RepairDataModel> call({required int pageIndex}) async =>
      await repairRepository.getRepairRequests(pageIndex: pageIndex);
}
