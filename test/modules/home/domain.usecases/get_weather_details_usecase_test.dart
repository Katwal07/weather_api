import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/core/error/failure.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_weather_details_usecase.dart';
import 'package:weather_app_api/service_locator.dart';

import '../mock/mock.mocks.dart';


void main() {
  late GetWeatherDetailsUsecase getWeatherDetailsUsecase;
  late MockWeatherRepository mockWeatherRepository;

  String location = "Damak";
  String aqi = "yes";

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherDetailsUsecase = GetWeatherDetailsUsecase();
    sl.registerLazySingleton<WeatherRepository>(
      () => mockWeatherRepository,
    );
  });

  /// Mocked Weather Details
  final weatherDetails = WeatherEntity(
    location: LocationEntity(
      name: "Pokhara",
      region: "Gandaki",
      country: "Nepal",
      lat: 28.2096,
      lon: 83.9856,
      tzId: "Asia/Kathmandu",
      localtimeEpoch: 1672531200,
      localtime: "2025-01-01 12:00",
    ),
    current: CurrentWeatherEntity(
      lastUpdatedEpoch: 1672531200,
      lastUpdated: "2025-01-01 12:00",
      tempC: 25.0,
      tempF: 77.0,
      isDay: 1,
      condition: ConditionEntity(
        text: "Sunny",
        icon: "//cdn.weatherapi.com/icons/sunny.png",
        code: 1000,
      ),
      windMph: 5.0,
      windKph: 8.0,
      windDegree: 180,
      windDir: "S",
      pressureMb: 1012.0,
      pressureIn: 29.88,
      precipMm: 0.0,
      precipIn: 0.0,
      humidity: 60,
      cloud: 0,
      feelslikeC: 26.0,
      feelslikeF: 78.8,
      windchillC: 25.0,
      windchillF: 77.0,
      heatindexC: 26.0,
      heatindexF: 78.8,
      dewpointC: 16.0,
      dewpointF: 60.8,
      visKm: 10.0,
      visMiles: 6.2,
      uv: 7.0,
      gustMph: 10.0,
      gustKph: 16.0,
      airQuality: {"pm10": 50.0, "pm2_5": 35.0},
    ),
  );

  /// Text Definition
  test('should get current weather details from the repository', () async {
    debugPrint('Weather List: $weatherDetails');

    /// Arrange
    when(mockWeatherRepository.getCurrentWeather(any, any)).thenAnswer(
      (_) async => Right(weatherDetails),
    );

    /// Act
    final result =
        await getWeatherDetailsUsecase(param1: location, param2: aqi);
    debugPrint("Result: $result");

    /// Assert
    expect(result, Right(weatherDetails));
    verify(mockWeatherRepository.getCurrentWeather(location, aqi));
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test("should return failure when the repository fails", ()async{
    /// Arrange
    final tError = ServerFailure(message: "Failed to fetch data from API.");
    when(mockWeatherRepository.getCurrentWeather(any, any)).thenAnswer((_)async => Left(tError));

    /// Act
    final result = await getWeatherDetailsUsecase(param1: location, param2: aqi);

    /// Assert
    expect(result, Left(tError));
    verify(mockWeatherRepository.getCurrentWeather(location, aqi));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
