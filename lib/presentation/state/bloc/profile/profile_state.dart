part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.user, this.repairData, this.currentPage, this.totalPages);
  final User user;
  final List<RepairRequest> repairData;
  final int currentPage;
  final int totalPages;
  @override
  List<Object> get props => [user,repairData,currentPage,totalPages];
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);
  final String message;
  

  @override
  List<Object> get props => [message];
}