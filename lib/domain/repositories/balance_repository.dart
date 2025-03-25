import 'package:fixiez/domain/entities/user.dart';

abstract class BalanceRepository {
  Future<User> getBalance();
}
