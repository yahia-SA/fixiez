import 'package:fixiez/domain/entities/felix.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class CreateFelixUseCase {
  CreateFelixUseCase(this.adminRepository);
  final AdminRepository adminRepository;
  Future<FelixEntity> call({
    required int felixNumber,
    required double cost,
  }) async =>
      await adminRepository.createFelix(felixNumber: felixNumber, cost: cost);
}
