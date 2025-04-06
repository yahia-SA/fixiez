part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoading  extends UsersState {}

final class UsersSuccess extends UsersState {

  const UsersSuccess({this.users, this.totalPages, this.currentPage, this.totalItems});
  final UsersMdoel? users;
  final int? totalPages;
  final int? currentPage;
  final int? totalItems;
  @override
  List<Object> get props => [users!, totalPages!, currentPage!, totalItems!];
}

final class UsersFailure extends UsersState {
  const UsersFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
final class UsersUpdating extends UsersState {}
final class UsersUpdated extends UsersState {}
final class UsersDeleted extends UsersState {}
