abstract class AppException implements Exception{
  final String? message;

  AppException({required this.message});
}

class ServerException extends AppException{
  ServerException({required super.message});
}

