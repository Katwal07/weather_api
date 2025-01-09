import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Exception exception){
  if(exception is ServerException){
    return ServerFailure(message: exception.message ?? "Server error occured");
  }
  if(exception is CacheException){
    return CacheFailure(message: exception.message ?? "Cache error occured");
  }
  else{
    return UnExceptedFailure(message: "An unexpected error occured");
  }
}