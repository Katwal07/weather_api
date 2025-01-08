import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String location, String aqi);
}
