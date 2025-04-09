import 'package:fixiez/domain/repositories/admin_repository.dart';

class DeleteFelixUseCase {
  DeleteFelixUseCase(this.adminRepository);
  final AdminRepository adminRepository;

  Future<bool> call({required String id}) async =>
      await adminRepository.deleteFelix(id: id);
}
