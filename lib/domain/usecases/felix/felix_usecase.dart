import 'package:fixiez/domain/entities/felix.dart';
import 'package:fixiez/domain/repositories/felix_repository.dart';

class FelixUsecase {
  FelixUsecase(this.felixRepository);
  final FelixRepository felixRepository;
  Future<List<FelixEntity>> call() => felixRepository.getFelix();
}
