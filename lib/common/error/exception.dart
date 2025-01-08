abstract class AppException implements Exception{
  final String? message;

  AppException({required this.message});
}

class ServerException extends AppException{
  ServerException({required super.message});
}

class CacheException extends AppException{
  CacheException({required super.message});
}

