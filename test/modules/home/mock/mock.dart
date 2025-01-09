import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/modules/home/data/sources/remote/weather_remote_datasource.dart.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherApiSource,
    Dio,
    DioClient,
  ],
  customMocks: [
    MockSpec<Dio>(as: #MockDioPackage),
    MockSpec<DioClient>(as: #MockDioClientCustom),
  ],
)
void main() {}
