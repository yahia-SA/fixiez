part of 'repair_admin_cubit.dart';

sealed class RepairAdminState extends Equatable {
  const RepairAdminState();

  @override
  List<Object> get props => [];
}

final class RepairAdminInitial extends RepairAdminState {}

final class RepairAdminLoading extends RepairAdminState {}

final class RepairAdminSuccess extends RepairAdminState {
  const RepairAdminSuccess({
    this.repairRequestResponse,
    this.totalPages,
    this.currentPage,
    this.totalItems,
  });
  final RepairRequestResponse? repairRequestResponse;
  final int? totalPages;
  final int? currentPage;
  final int? totalItems;
  @override
  List<Object> get props => [
    repairRequestResponse ??  RepairRequestResponse() ,
    totalPages ?? 1,
    currentPage ?? 1,
    totalItems ?? 0,
  ];
}

final class RepairAdminFailure extends RepairAdminState {
  const RepairAdminFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
