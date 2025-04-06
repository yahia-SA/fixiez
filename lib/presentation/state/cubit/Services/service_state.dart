part of 'service_cubit.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServiceSuccess extends ServiceState {
  const ServiceSuccess(this.service);
  final List<Services> service;
  
  @override
  List<Object> get props => [service];
}

final class ServiceFailure extends ServiceState {
  const ServiceFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
class ServiceUpdating extends ServiceState {}

class ServiceUpdated extends ServiceState {}

