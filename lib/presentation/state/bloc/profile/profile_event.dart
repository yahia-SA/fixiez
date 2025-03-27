part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class GetBalance extends ProfileEvent {
    @override
  List<Object> get props => [];

}
class GetRepairRequests extends ProfileEvent {
  const GetRepairRequests({required this.pageIndex});
  final int pageIndex;
  
  @override
  List<Object> get props => [pageIndex];

}
class GetProfile extends ProfileEvent {
  @override
  List<Object> get props => [];
}

