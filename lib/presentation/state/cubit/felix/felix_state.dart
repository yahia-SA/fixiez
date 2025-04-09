part of 'felix_cubit.dart';

sealed class FelixState extends Equatable {
  const FelixState();

  @override
  List<Object> get props => [];
}

final class FelixInitial extends FelixState {}

final class FelixLoading extends FelixState {}

final class FelixSuccess extends FelixState {
  const FelixSuccess({this.felix,this.totalPages, this.currentPage, this.totalItems});
  final FelixResponse? felix;
    final int? totalPages;
  final int? currentPage;
  final int? totalItems;

  @override
  List<Object> get props => [felix!, totalPages!, currentPage!, totalItems!];
}

final class FelixFailure extends FelixState {
  const FelixFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
final class FelixDeleting extends FelixState {}

final class FelixDeleted extends FelixState {}

final class FelixCreating extends FelixState {}

final class FelixCreated extends FelixState {}
final class FelixUpdating extends FelixState {}

final class FelixUpdated extends FelixState {}


