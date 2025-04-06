import 'package:fixiez/domain/entities/services.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class GetAdminServicesUseCase {

  GetAdminServicesUseCase( this.adminRepository);
  final AdminRepository adminRepository;

  Future<List<Services>> call() async => await adminRepository.getServices();
}