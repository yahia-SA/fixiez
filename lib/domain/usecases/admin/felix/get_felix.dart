import 'package:fixiez/data/models/felix_model.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class GetFelixUsecase {
  GetFelixUsecase(this.felixRepository);
  final AdminRepository felixRepository;

  Future<FelixResponse> call({required int pageIndex}) async =>
      await felixRepository.getFelix(pageIndex: pageIndex);
}
