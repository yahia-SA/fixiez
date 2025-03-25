import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/balance_repository.dart';

class GetBalanceUseCase {

  GetBalanceUseCase( this.balanceRepository);
  final BalanceRepository balanceRepository;

  Future<User> call() async {
  return await balanceRepository.getBalance();

  }
  
}