import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

// Specific Failure Types
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}
