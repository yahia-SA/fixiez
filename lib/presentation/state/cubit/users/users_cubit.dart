import 'package:equatable/equatable.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/usecases/admin/users_admin/admin_delete_users_usecase.dart';
import 'package:fixiez/domain/usecases/admin/users_admin/admin_get_users_usecase.dart';
import 'package:fixiez/domain/usecases/admin/users_admin/admin_update_users_usecase.dart';
import 'package:fixiez/domain/usecases/auth/delete_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({
    required this.adminUpdateUsersUseCase,
    required this.getAdminUsersUseCase,
    required this.adminDeleteUsersUsecase,
    required this.deleteUsersUsecase,
  }) : super(UsersInitial());
  final GetAdminUsersUseCase getAdminUsersUseCase;
  final UpdateAdminUserUseCase adminUpdateUsersUseCase;
  final AdminDeleteUsersUsecase adminDeleteUsersUsecase;
  final DeleteUserUseCase deleteUsersUsecase;
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

  Future<void> updateAdminUser({
    required String id,
    required String role,
  }) async {
    emit(UsersUpdating());
    try {
      final success = await adminUpdateUsersUseCase(id: id, role: role);
      if (success) {
        emit(UsersUpdated());
      } else {
        emit(const UsersFailure('Failed to update user.'));
      }
    } catch (e) {
      emit(UsersFailure(e.toString()));
    }
  }

  Future<bool> deleteAdminUser({required String id}) async {
    emit(UsersDeleting());
    try {
      await adminDeleteUsersUsecase(id: id);
      emit(UsersDeleted());
      return true;
    } catch (e) {
      emit(UsersFailure(e.toString()));
      return false;
    }
  }

  Future<bool> deleteUser() async {
    emit(UsersDeleting());
    try {
      await deleteUsersUsecase();
      emit(UsersDeleted());
      return true;
    } catch (e) {
      emit(UsersFailure(e.toString()));
      return false;
    }
  }
}
