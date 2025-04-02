import 'package:equatable/equatable.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/usecases/admin/admin_get_users_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.getAdminUsersUseCase) : super(UsersInitial());
  final GetAdminUsersUseCase getAdminUsersUseCase;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 1;
  bool _isLoading = false;
  UsersMdoel _usersModel = UsersMdoel();

  Future<void> getAdminUsers({required int pageIndex}) async {
    if (_isLoading || pageIndex < 1 || pageIndex > _totalPages) return;
    _isLoading = true;
    emit(UsersLoading());
    try {
      final UsersMdoel usersModel = await getAdminUsersUseCase.getUsers(
        pageIndex: pageIndex,
      );
      _currentPage = pageIndex;
      _totalPages = usersModel.metadata!.totalPages!;
      _usersModel = usersModel;
      _totalItems = usersModel.metadata!.totalItems!;
      emit(
        UsersSuccess(
          users: _usersModel,
          totalPages: _totalPages,
          currentPage: _currentPage,
          totalItems: _totalItems,
        ),
      );
    } catch (e) {
      emit(UsersFailure(e.toString()));
    }
    _isLoading = false;
  }
}
