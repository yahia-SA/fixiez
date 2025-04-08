import 'package:fixiez/data/models/repair_requsest_admin.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class GetRepairAdminUseCase {

GetRepairAdminUseCase( this.repairRepository);
final AdminRepository repairRepository; 
Future<RepairRequestResponse> call({required int pageIndex}) async => await repairRepository.getRepirs(pageIndex: pageIndex);  
}