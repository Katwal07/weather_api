abstract class Failure{
  final String? message;

  Failure({required this.message});
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class UnExceptedFailure extends Failure{
  UnExceptedFailure({required super.message});
  @override
  String toString() => "UnExpectedFailure: $message";
}

class CacheFailure extends Failure{
  CacheFailure({required super.message});
}