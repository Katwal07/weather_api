import 'package:dartz/dartz.dart';
import '../../../../common/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/location.dart';
import '../repositories/weather_repository.dart';

class GetSavedLocationUseCase extends LocationUsecase<Either<Failure, LocationEntityForStorage>, dynamic>{
  @override
  Future<Either<Failure, LocationEntityForStorage>> call({param}) async{
    return await sl<WeatherRepository>().getSavedLocation();
  }
}