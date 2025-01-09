import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/usecases/save_location_usecase.dart';
import 'package:weather_app_api/service_locator.dart';

import '../mock/mock.mocks.dart';


void main() {
  late SaveLocationUsecase saveLocationUsecase;
  late MockWeatherRepository mockWeatherRepository;

  final location = LocationEntityForStorage(
    name: "Pokhara",
    tempC: 12.0,
    weatherCon: "Sunny",
    weatherIcon: "//cdn.weatherapi.com/icons/sunny.png",
  );

  setUp(
    () {
      mockWeatherRepository = MockWeatherRepository();
      saveLocationUsecase = SaveLocationUsecase();
      sl.registerLazySingleton<WeatherRepository>(
        () => mockWeatherRepository,
      );
    },
  );

  test("should save location successfully", () async {
    /// Arrange
    when(mockWeatherRepository.saveLocation(any))
        .thenAnswer((_) async => const Right(null));

    /// Act
    final result = await saveLocationUsecase(param: location);

    /// Assert
    expect(result, Right(null));
    verify(mockWeatherRepository.saveLocation(location));
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test("should returns failure when savLocation fails", () async {
    /// Arrange
    final tError = CacheFailure(message: "Fail to save location");
    when(mockWeatherRepository.saveLocation(any))
        .thenAnswer((_) async => Left(tError));

    /// Act
    final result = await saveLocationUsecase(param: location);

    /// Assert
    expect(result, Left(tError));
    verify(mockWeatherRepository.saveLocation(location));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
