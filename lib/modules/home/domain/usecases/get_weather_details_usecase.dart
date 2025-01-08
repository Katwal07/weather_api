import 'package:dartz/dartz.dart';
import 'package:weather_app_api/core/usecase/usecase.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/service_locator.dart';
import '../../../../common/error/failure.dart';

class GetWeatherDetailsUsecase extends Usecase<Either<Failure, WeatherEntity>, String , String>{
  @override
  Future<Either<Failure, WeatherEntity>> call({String ? param1, String ? param2}) async{
    return await sl<WeatherRepository>().getCurrentWeather(param1!, param2!);
  }
}