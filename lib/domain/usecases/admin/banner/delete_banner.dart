import 'package:fixiez/domain/repositories/admin_repository.dart';

class DeleteBannerAdminUseCase {
  DeleteBannerAdminUseCase(this.adminRepository);

  final AdminRepository adminRepository;

  Future<bool> call({required String id}) async => await adminRepository.deleteBanner(id: id);
}
