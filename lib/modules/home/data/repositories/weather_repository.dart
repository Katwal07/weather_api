import 'package:dartz/dartz.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/common/error/mapping.dart';
import 'package:weather_app_api/common/mapper/weather_mapper.dart';
import 'package:weather_app_api/modules/home/data/sources/weather_api.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/service_locator.dart';

class WeatherRepositoryImpl extends WeatherRepository{
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String location, String aqi) async{
    Either returnedData = await sl<WeatherApiSource>().getCurrentWeather(location, aqi);
    return returnedData.fold(
      (error){
        return Left(mapExceptionToFailure(error));
      }, 
      (data){
        final weatherDetails = WeatherMapper.toWeatherEntity(data);
        return Right(weatherDetails);
      }
    );
  }
}