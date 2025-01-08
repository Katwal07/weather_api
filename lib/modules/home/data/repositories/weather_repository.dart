import 'package:dartz/dartz.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/common/error/mapping.dart';
import 'package:weather_app_api/common/mapper/weather_mapper.dart';
import 'package:weather_app_api/modules/home/data/models/location.dart';
import 'package:weather_app_api/modules/home/data/sources/local/weather_local_datasource.dart';
import 'package:weather_app_api/modules/home/data/sources/remote/weather_remote_datasource.dart.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/service_locator.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String location, String aqi) async {
    Either returnedData =
        await sl<WeatherApiSource>().getCurrentWeather(location, aqi);
    return returnedData.fold((error) {
      return Left(mapExceptionToFailure(error));
    }, (data) {
      final weatherDetails = WeatherMapper.toWeatherEntity(data);
      return Right(weatherDetails);
    });
  }

  @override
  Future<Either<Failure, LocationEntityForStorage>> getSavedLocation() async {
    Either getSavedLocation =
        await sl<WeatherLocalDatasource>().getSavedLocation();
    return getSavedLocation.fold((error) {
      return Left(
        CacheFailure(message: error),
      );
    }, (data) {
      if (data != null) {
        return Right(data.toEntity());
      } else {
        return Left(CacheFailure(message: "Cache Failure Occur"));
      }
    });
  }

  @override
  Future<Either<Failure, void>> saveLocation(
      LocationEntityForStorage location) async {
    try {
      final saveLocation = LocationModelForStorage.fromEntity(location);
      await sl<WeatherLocalDatasource>().saveLocation(saveLocation);
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
