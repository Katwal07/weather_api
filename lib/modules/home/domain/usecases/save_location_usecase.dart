import 'package:dartz/dartz.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/core/usecase/usecase.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/service_locator.dart';

class SaveLocationUsecase extends LocationUsecase<Either<Failure, void>, LocationEntityForStorage>{
  @override
  Future<Either<Failure, void>> call({LocationEntityForStorage ? param}) async{
    return await sl<WeatherRepository>().saveLocation(param!);
  }
}