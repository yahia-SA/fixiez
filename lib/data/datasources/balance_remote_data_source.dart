
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/domain/entities/balance.dart';
import 'package:fixiez/domain/entities/user.dart';

abstract class BalanceRemoteDataSource {
  Future<User> getBalance();
}

class BalanceRemoteDataSourceImpl implements BalanceRemoteDataSource {

  BalanceRemoteDataSourceImpl(this.dio);
  final DioHelper dio;

  @override
  Future<User> getBalance() async {
    try {
      final response = await dio.getData( url: ApiEndpoints.balanceCashBack,
      );
      if (response.data['status'] == 'success') {
    final balanceData = BalanceResponse.fromJson(response.data['data']);
    final cachedUser = CacheHelper.getUser();
    return cachedUser!.copyWith(
      balance: balanceData.balance,
      cashBack: balanceData.cashBack
    );
    

      } else {
        throw Exception('Failed to fetch balance data');
      }
    }   catch (e) {
      throw Exception('Failed to fetch balance data: ${e.toString()}');
    }
  }
}
