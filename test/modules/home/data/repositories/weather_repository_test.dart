import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/common/error/exception.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/modules/home/data/models/weather.dart';
import 'package:weather_app_api/modules/home/data/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';

import '../../mock/mock.mocks.dart';

void main() {
  late MockWeatherApiSource mockWeatherApiSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherApiSource = MockWeatherApiSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherApiSource: mockWeatherApiSource);
  });

  const testWeatherModel = WeatherModel(
    location: LocationModel(
      name: "Pokhara",
      region: "Gandaki",
      country: "Nepal",
      lat: 28.2333,
      lon: 83.9833,
      tzId: "Asia/Kathmandu",
      localtimeEpoch: 1736319218,
      localtime: "2025-01-08 12:38",
    ),
    current: CurrentWeatherModel(
      lastUpdatedEpoch: 1736318700,
      lastUpdated: "2025-01-08 12:30",
      tempC: 17.4,
      tempF: 63.3,
      isDay: 1,
      condition: ConditionModel(
        text: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
        code: 1000,
      ),
      windMph: 6.5,
      windKph: 10.4,
      windDegree: 167,
      windDir: "SSE",
      pressureMb: 1014.0,
      pressureIn: 29.94,
      precipMm: 0.0,
      precipIn: 0.0,
      humidity: 43,
      cloud: 6,
      feelslikeC: 17.4,
      feelslikeF: 63.3,
      windchillC: 17.4,
      windchillF: 63.3,
      heatindexC: 17.4,
      heatindexF: 63.3,
      dewpointC: 4.9,
      dewpointF: 40.7,
      visKm: 10.0,
      visMiles: 6.0,
      uv: 4.4,
      gustMph: 7.5,
      gustKph: 12.0,
      airQuality: {
        "co": 2469.75,
        "no2": 18.5,
        "o3": 73.0,
        "so2": 7.4,
        "pm2_5": 61.42,
        "pm10": 63.27,
        "us-epa-index": 3,
        "gb-defra-index": 8,
      },
    ),
  );

  const testWeatherEntity = WeatherEntity(
    location: LocationEntity(
      name: "Pokhara",
      region: "Gandaki",
      country: "Nepal",
      lat: 28.2333,
      lon: 83.9833,
      tzId: "Asia/Kathmandu",
      localtimeEpoch: 1736319218,
      localtime: "2025-01-08 12:38",
    ),
    current: CurrentWeatherEntity(
      lastUpdatedEpoch: 1736318700,
      lastUpdated: "2025-01-08 12:30",
      tempC: 17.4,
      tempF: 63.3,
      isDay: 1,
      condition: ConditionEntity(
        text: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
        code: 1000,
      ),
      windMph: 6.5,
      windKph: 10.4,
      windDegree: 167,
      windDir: "SSE",
      pressureMb: 1014.0,
      pressureIn: 29.94,
      precipMm: 0.0,
      precipIn: 0.0,
      humidity: 43,
      cloud: 6,
      feelslikeC: 17.4,
      feelslikeF: 63.3,
      windchillC: 17.4,
      windchillF: 63.3,
      heatindexC: 17.4,
      heatindexF: 63.3,
      dewpointC: 4.9,
      dewpointF: 40.7,
      visKm: 10.0,
      visMiles: 6.0,
      uv: 4.4,
      gustMph: 7.5,
      gustKph: 12.0,
      airQuality: {
        "co": 2469.75,
        "no2": 18.5,
        "o3": 73.0,
        "so2": 7.4,
        "pm2_5": 61.42,
        "pm10": 63.27,
        "us-epa-index": 3,
        "gb-defra-index": 8,
      },
    ),
  );

  String location = "Damak";
  String aqi = "yes";

  group("get current weather details", () {
    test(
        "should return current weather when a call to data source is successful",
        () async {
      /// Arrange
      when(mockWeatherApiSource.getCurrentWeather(location, aqi)).thenAnswer(
        (_) async => Right(testWeatherModel),
      );

      /// Act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(location, aqi);

      /// Assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });

  test("should return server failure when a call to data source fails",
      () async {
    final tError = ServerException(message: "Failed to fetch data from API.");

    /// Arrange
    when(mockWeatherApiSource.getCurrentWeather(location, aqi)).thenAnswer(
      (_) async => Left(tError),
    );

    /// Act
    final result = await weatherRepositoryImpl.getCurrentWeather(location, aqi);

    final fError = ServerFailure(message: "Failed to fetch data from API.");

    /// Assert
    expect(result, Left(fError,));
  });
}
