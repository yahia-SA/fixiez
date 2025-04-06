import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class GetAdminUsersUseCase{
GetAdminUsersUseCase( this.adminRepository); 
final AdminRepository adminRepository;
Future<UsersMdoel> getUsers({required int pageIndex,}) async => await adminRepository.getUsers(pageIndex: pageIndex);
}