part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  const GetProfile({this.pageIndex = 1, this.repairOnly = false});
  final int pageIndex;
  final bool repairOnly;
  @override
  List<Object> get props => [pageIndex, repairOnly];
}

class RepairRequestsUpdate extends ProfileEvent {
  const RepairRequestsUpdate({required this.id, required this.status});
  final String id;
  final String status;
  @override
  List<Object> get props => [id, status];
}
