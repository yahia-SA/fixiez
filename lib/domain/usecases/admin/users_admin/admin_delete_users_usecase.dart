import 'package:fixiez/domain/repositories/admin_repository.dart';

class AdminDeleteUsersUsecase {
  AdminDeleteUsersUsecase( this.adminRepository);
  final AdminRepository adminRepository;

  Future<bool> call({required String id}) async => await adminRepository.deleteUser(id: id);
  
}