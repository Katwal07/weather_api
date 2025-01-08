import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_api/common/error/exception.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/modules/home/data/models/weather.dart';
import 'package:weather_app_api/service_locator.dart';

abstract class WeatherApiSource {
  Future<Either<AppException, WeatherModel>> getCurrentWeather(
    String location,
    String aqi,
  );
}

class WeatherApiSourceImpl extends WeatherApiSource {
  @override
  Future<Either<AppException, WeatherModel>> getCurrentWeather(
      String location, String aqi) async {
    try {
      var response =
          await sl<DioClient>().getRequest(path: "&q=$location&aqi=$aqi");
      final weatherDetails = WeatherModel.fromJson(response.data);
      return Right(weatherDetails);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw ServerException(message: "Unable To Connect To Server");
      }
      return Left(ServerException(
          message: "Failed to fetch weather details"));
    }
  }
}
