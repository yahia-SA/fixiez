import 'package:fixiez/domain/analtyis_model.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class AnalysisAdminUseCase {
  AnalysisAdminUseCase(this.adminRepository);
  final AdminRepository adminRepository;

  Future<AnalysisModel> call() async => await adminRepository.getAnalysis();
}
