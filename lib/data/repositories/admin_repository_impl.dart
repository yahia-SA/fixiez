import 'package:fixiez/data/datasources/admin_remote_data_source.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl({required this.remoteDataSource});
  final AdminRemoteDataSource remoteDataSource;
  @override
  Future<UsersMdoel> getUsers(
    {required int pageIndex,}
  ) async {
    final response = await remoteDataSource.getUsers(pageIndex: pageIndex);
    return response;
  }

  
}