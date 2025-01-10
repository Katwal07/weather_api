import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/core/usecase/usecase.dart';
import 'package:weather_app_api/modules/home/data/sources/remote/weather_remote_datasource.dart.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/presentation/logic/geolocator/geolocator_wrapper.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherApiSource,
    Dio,
    DioClient,
    Geolocator,
    Usecase,
    GeolocatorWrapper
  ],
  customMocks: [
    MockSpec<Dio>(as: #MockDioPackage),
    MockSpec<DioClient>(as: #MockDioClientCustom),
  ],
)
void main() {}
