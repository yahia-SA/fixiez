import 'package:fixiez/data/datasources/felix_remote_data_source.dart';
import 'package:fixiez/domain/entities/felix.dart';
import 'package:fixiez/domain/repositories/felix_repository.dart';

class FelixRepositoryImpl implements FelixRepository {
  FelixRepositoryImpl({required this.remoteDataSource});
  final FelixRemoteDataSource remoteDataSource;
  @override
  Future<List<FelixEntity>> getFelix() async {
    final response = await remoteDataSource.getFelix();
    return response.data!.map((e) => e.toEntity()).toList();
  }
}
