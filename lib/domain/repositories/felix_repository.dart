import 'package:fixiez/domain/entities/felix.dart';

abstract class FelixRepository {
  Future<List<FelixEntity>> getFelix();
}