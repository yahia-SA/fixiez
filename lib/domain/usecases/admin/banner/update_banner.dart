import 'package:fixiez/domain/repositories/admin_repository.dart';

class UpdateBannerAdminUseCase{
UpdateBannerAdminUseCase( this.adminRepository); 
final AdminRepository adminRepository;
  Future<bool> call({required String id,required bool isActive}) async => await adminRepository.updateBanner(id: id, isActive: isActive);
  
}