import 'package:fixiez/data/datasources/balance_remote_data_source.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {

  BalanceRepositoryImpl(this.remoteDataSource);
  final BalanceRemoteDataSource remoteDataSource;

  @override
  Future<User> getBalance() async {
    return  await remoteDataSource.getBalance();
  }
}
