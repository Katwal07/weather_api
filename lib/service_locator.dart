import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:weather_app_api/core/network/dio.dart';
import 'package:weather_app_api/modules/home/data/models/location.dart';
import 'package:weather_app_api/modules/home/data/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/data/sources/local/weather_local_datasource.dart';
import 'package:weather_app_api/modules/home/data/sources/remote/weather_remote_datasource.dart.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_saved_location_usecase.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_weather_details_usecase.dart';
import 'package:weather_app_api/modules/home/domain/usecases/save_location_usecase.dart';

final sl = GetIt.instance;

void setUpServiceLocator(Box<LocationModelForStorage> locationBox) async{
  /// HTTPs Request
  sl.registerSingleton<DioClient>(DioClient());
  /// APIs Service
  sl.registerSingleton<WeatherApiSource>(WeatherApiSourceImpl());
  /// Hive Service
  sl.registerSingleton<WeatherLocalDatasource>(WeatherLocalDatasourceImpl(locationBox: locationBox));
  /// Repository
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl());
  /// Usecases
  sl.registerSingleton<GetWeatherDetailsUsecase>(GetWeatherDetailsUsecase());
  sl.registerSingleton<GetSavedLocationUseCase>(GetSavedLocationUseCase());
  sl.registerSingleton<SaveLocationUsecase>(SaveLocationUsecase());
}