import 'package:dio/dio.dart';
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

final GetIt sl = GetIt.instance;

void setUpServiceLocator(Box<LocationModelForStorage> locationBox){
  /// HTTPs Request : Registering Dio Client.
  final dioClient = DioClient();
  dioClient.dio = Dio();
  sl.registerSingleton<DioClient>(dioClient);
  /// APIs Service : Registering the WeatherApiSource.
  sl.registerSingleton<WeatherApiSource>(WeatherApiSourceImpl(dioClient: sl()));
  /// Hive Service : Registering the Weather Local DataSource.
  sl.registerSingleton<WeatherLocalDatasource>(WeatherLocalDatasourceImpl(locationBox: locationBox));
  /// Repository : Registering the Weather Repository.
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(weatherApiSource: sl()));
  /// Usecases : Registering the use cases.
  sl.registerSingleton<GetWeatherDetailsUsecase>(GetWeatherDetailsUsecase());
  sl.registerSingleton<GetSavedLocationUseCase>(GetSavedLocationUseCase());
  sl.registerSingleton<SaveLocationUsecase>(SaveLocationUsecase());
}