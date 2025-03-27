part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class GetBalance extends ProfileEvent {}
class GetRepairRequests extends ProfileEvent {
  const GetRepairRequests({required this.pageIndex});
  final int pageIndex;
  
  @override
  List<Object> get props => [pageIndex];

}
class InitializeProfile extends ProfileEvent {}