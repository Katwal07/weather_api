import 'package:weather_app_api/modules/home/domain/entities/weather.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState{}

class WeatherLoadingState extends WeatherState{}

class WeatherLoadedState extends WeatherState{
  final WeatherEntity weatherData;

  WeatherLoadedState({required this.weatherData});
}

class FailToLoadWeatherState extends WeatherState{
  final String errorMessage;

  FailToLoadWeatherState({required this.errorMessage});
}