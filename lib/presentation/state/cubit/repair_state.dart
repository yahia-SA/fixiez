part of 'repair_cubit.dart';

sealed class RepairState extends Equatable {
  const RepairState();

  @override
  List<Object> get props => [];
}

final class RepairInitial extends RepairState {}
final class RepairLoading extends RepairState {}
final class Repairsuccess extends RepairState {}
final class RepairFailure extends RepairState {
  const RepairFailure(this.message);
  final String message;
    @override
  List<Object> get props => [message];

}
