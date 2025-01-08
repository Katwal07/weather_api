import 'package:dartz/dartz.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import '../../../../common/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String location, String aqi);
  Future<Either<Failure, LocationEntityForStorage>> getSavedLocation();
  Future<Either<Failure, void>> saveLocation(LocationEntityForStorage location);
}
