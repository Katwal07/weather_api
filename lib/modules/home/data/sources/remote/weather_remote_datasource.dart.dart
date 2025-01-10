import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_api/core/error/exception.dart';
import 'package:weather_app_api/core/network/api_const.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/modules/home/data/models/weather.dart';

abstract class WeatherApiSource {
  Future<Either<AppException, WeatherModel>> getCurrentWeather(
    String location,
    String aqi,
  );
}

class WeatherApiSourceImpl extends WeatherApiSource {
  final DioClient dioClient;

  WeatherApiSourceImpl({required this.dioClient});
  @override
  Future<Either<AppException, WeatherModel>> getCurrentWeather(
      String location, String aqi) async {
    try {
      var response =
          await dioClient.getRequest(
            path: baseUrl, 
            queryParameters: {
              'key': apiKey,
              'q': location,
              'aqi': aqi
            }
          );
      final weatherDetails = WeatherModel.fromJson(response.data);
      return Right(weatherDetails);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return  Left(ServerException(message: "Unable To Connect To Server"));
      }
      return Left(ServerException(
          message: "Location not found"));
    }
  }
}
