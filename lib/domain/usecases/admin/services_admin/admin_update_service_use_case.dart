import 'package:fixiez/domain/repositories/admin_repository.dart';

class UpdateAdminServiceUseCase {

  UpdateAdminServiceUseCase( this.adminRepository);
  final AdminRepository adminRepository;
    Future<bool> call({required String id,required int cost}) async => await adminRepository.updateService(id: id, cost: cost);

  
}