import 'package:get_it/get_it.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/modules/home/data/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/data/sources/weather_api.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_weather_details_usecase.dart';

final sl = GetIt.instance;

void setUpServiceLocator(){
  /// HTTPs Request
  sl.registerSingleton<DioClient>(DioClient());
  /// APIs Service
  sl.registerSingleton<WeatherApiSource>(WeatherApiSourceImpl());
  /// Repository
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl());
  /// Usecases
  sl.registerSingleton<GetWeatherDetailsUsecase>(GetWeatherDetailsUsecase());
}