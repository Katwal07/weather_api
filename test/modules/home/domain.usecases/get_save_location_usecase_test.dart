import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/common/error/failure.dart';
import 'package:weather_app_api/modules/home/domain/entities/location.dart';
import 'package:weather_app_api/modules/home/domain/repositories/weather_repository.dart';
import 'package:weather_app_api/modules/home/domain/usecases/get_saved_location_usecase.dart';
import 'package:weather_app_api/service_locator.dart';

import '../mock/mock.mocks.dart';

void main() {
  late GetSavedLocationUseCase getSavedLocationUseCase;
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
      getSavedLocationUseCase = GetSavedLocationUseCase();
      sl.registerLazySingleton<WeatherRepository>(
        () => mockWeatherRepository,
      );
    },
  );

  test("should get save location successfully", () async {
    /// Arrange
    when(mockWeatherRepository.getSavedLocation())
        .thenAnswer((_) async => Right(location));

    /// Act
    final result = await getSavedLocationUseCase();

    /// Assert
    expect(result, Right(location));
    verify(mockWeatherRepository.getSavedLocation());
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test("should returns failure when getLocation fails", () async {
    /// Arrange
    final tError = CacheFailure(message: "Fail to get save location");
    when(mockWeatherRepository.getSavedLocation())
        .thenAnswer((_) async => Left(tError));

    /// Act
    final result = await getSavedLocationUseCase();

    /// Assert
    expect(result, Left(tError));
    verify(mockWeatherRepository.getSavedLocation());
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
