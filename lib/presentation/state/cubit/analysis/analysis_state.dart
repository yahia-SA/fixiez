part of 'analysis_cubit.dart';

sealed class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object> get props => [];
}

final class AnalysisInitial extends AnalysisState {}

final class AnalysisLoading extends AnalysisState {}

final class AnalysisSuccess extends AnalysisState {

  const AnalysisSuccess({this.repairRequestResult, this.userResult});
  final RepairRequestResult? repairRequestResult;
  final UserResult? userResult;

  @override
  List<Object> get props => [repairRequestResult!, userResult!];
}

final class AnalysisFailure extends AnalysisState {
  const AnalysisFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
