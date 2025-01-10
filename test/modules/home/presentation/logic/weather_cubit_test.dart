import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/core/error/failure.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_cubit.dart';
import 'package:weather_app_api/modules/home/presentation/logic/weather/weather_state.dart';

import '../../mock/mock.mocks.dart';

void main() {
  late WeatherCubit weatherCubit;
  late MockUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockUsecase();
    weatherCubit = WeatherCubit();
  });

  tearDown(() {
    weatherCubit.close();
  });

  group("Weather Cubit Tests", () {
    const testParam1 = "Pokhara";
    const testParam2 = 'yes';

    final testWeatherDetails = WeatherEntity(
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

    test("initial state should be [WeatherInitialState]", () {
      expect(weatherCubit.state, isA<WeatherInitialState>());
    });

    blocTest<WeatherCubit, WeatherState>(
      "should emit [WeatherLoadingState] and [WeatherLoadedState] when data is successfully fetched",
      build: () {
        when(mockUsecase.call(param1: testParam1, param2: testParam2))
            .thenAnswer((_) async => Right(testWeatherDetails));
        return weatherCubit;
      },
      act: (cubit) => cubit.execute(
          usecase: mockUsecase, param1: testParam1, param2: testParam2),
      expect: () => [
        isA<WeatherLoadingState>(),
        isA<WeatherLoadedState>().having(
          (state) => state.weatherData,
          "weather data",
          equals(testWeatherDetails),
        ),
      ],
      verify: (_){
        verify(mockUsecase.call(param1: testParam1,param2: testParam2)).called(1);
      }
    );

    blocTest<WeatherCubit, WeatherState>(
      'should emits [WeatherLoadingState, FailToLoadWeatherState] when server failure occurs',
      build: () {
        when(mockUsecase.call(param1: testParam1, param2: testParam2))
            .thenAnswer((_) async => Left(ServerFailure(message: 'Failed to Fetch Weather')));
        return weatherCubit;
      },
      act: (cubit) => cubit.execute(
        usecase: mockUsecase,
        param1: testParam1,
        param2: testParam2,
      ),
      expect: () => [
        isA<WeatherLoadingState>(),
        isA<FailToLoadWeatherState>(),
        isA<FailToLoadWeatherState>(),
      ],
    );

     blocTest<WeatherCubit, WeatherState>(
      'should emits [WeatherLoadingState, FailToLoadWeatherState] when unexpected failure occurs',
      build: () {
        when(mockUsecase.call(param1: testParam1, param2: testParam2))
            .thenAnswer((_) async => Left(UnExceptedFailure(message: 'UnExpected error occured')));
        return weatherCubit;
      },
      act: (cubit) => cubit.execute(
        usecase: mockUsecase,
        param1: testParam1,
        param2: testParam2,
      ),
      expect: () => [
        isA<WeatherLoadingState>(),
        isA<FailToLoadWeatherState>(),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'should emits [WeatherLoadingState, FailToLoadWeatherState] with "No Location Found" when location not found',
      build: () {
        when(mockUsecase.call(param1: testParam1, param2: testParam2))
            .thenAnswer((_) async => Left(ServerFailure(message: "Location not found")));
        return weatherCubit;
      },
      act: (cubit) => cubit.execute(
        usecase: mockUsecase,
        param1: testParam1,
        param2: testParam2,
      ),
      expect: () => [
        isA<WeatherLoadingState>(),
        isA<FailToLoadWeatherState>(),
        isA<FailToLoadWeatherState>()
      ],
    );
  });
}
