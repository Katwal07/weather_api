import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Exception exception){
  if(exception is ServerException){
    return ServerFailure(message: exception.message ?? "Server error occured");
  }
  else{
    return UnExceptedFailure(message: "An unexpected error occured");
  }
}