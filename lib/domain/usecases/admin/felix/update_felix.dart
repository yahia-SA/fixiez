import 'package:fixiez/domain/repositories/admin_repository.dart';

class UpdateFelixUseCase {
  UpdateFelixUseCase(this.adminRepository);
  final AdminRepository adminRepository;

  Future<bool> call({
    required String id,
    required int felixNumber,
    required double cost,
  }) async => await adminRepository.updateFelix(
    id: id,
    felixNumber: felixNumber,
    cost: cost,
  );
}
