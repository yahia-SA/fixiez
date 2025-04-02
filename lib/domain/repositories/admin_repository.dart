import 'package:fixiez/data/models/users_model.dart';

abstract class AdminRepository {
    Future<UsersMdoel> getUsers({required int pageIndex});
  
}