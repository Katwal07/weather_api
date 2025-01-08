abstract class Usecase<Type, Param1, Param2> {
  Future<Type> call({Param1 param1 , Param2 param2});
}

abstract class LocationUsecase<Type, Params>{
  Future<Type> call({Params param});
}