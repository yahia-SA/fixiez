import 'package:fixiez/domain/repositories/admin_repository.dart';

class UpdateAdminUserUseCase{
UpdateAdminUserUseCase( this.adminRepository); 
final AdminRepository adminRepository;
    Future<bool> call({required String id,required String role}) async => await adminRepository.updateUser(id: id, role: role);
}