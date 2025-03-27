part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
class RepairRequestsLoading extends ProfileState {}
class RepairRequestsSuccess extends ProfileState {
  const RepairRequestsSuccess(this.repairData);
  final RepairData repairData;

  @override
  List<Object> get props => [repairData];
}
class RepairRequestsFailure extends ProfileState {
  const RepairRequestsFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}