import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String? message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure{
  const ServerFailure({required super.message});
  
  @override
  List<Object?> get props => [message];
}

class UnExceptedFailure extends Failure{
  const UnExceptedFailure({required super.message});
  @override
  String toString() => "UnExpectedFailure: $message";
  
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure{
  const CacheFailure({required super.message});
  
  @override
  List<Object?> get props => [message];
}