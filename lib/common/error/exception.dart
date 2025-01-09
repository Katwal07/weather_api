import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception{
  final String? message;

  const AppException({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerException extends AppException{
  const ServerException({required super.message});
  
  @override
  List<Object?> get props => [message];
}

class CacheException extends AppException{
  const CacheException({required super.message});
  
  @override
  List<Object?> get props => [message];
}

