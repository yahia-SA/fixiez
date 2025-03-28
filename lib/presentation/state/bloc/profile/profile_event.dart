part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class GetProfile extends ProfileEvent {
  const GetProfile({required this.pageIndex});
  final int pageIndex;
  @override
  List<Object> get props => [pageIndex];
}

