import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/core/error/exception.dart';
import 'package:weather_app_api/modules/home/data/models/weather.dart';
import 'package:weather_app_api/modules/home/data/sources/remote/weather_remote_datasource.dart.dart';
import '../../../mock/mock.mocks.dart';
import '../../dummy/json_reader.dart';
void main() {
  late WeatherApiSourceImpl weatherApiSourceImpl;
  late MockDioClient mockDioClient;

  setUp(() async {
    mockDioClient = MockDioClient();
    weatherApiSourceImpl = WeatherApiSourceImpl(dioClient: mockDioClient);
  });

  group("Weather Api Source Implementation", () {
    const location = "Pokhara";
      const aqi = 'yes';
      final testPath = "&q=$location&aqi=$aqi";
    test("returns WeatherModel on successful API call", () async {
      

      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'modules/home/data/dummy/dummy_weather_response.json',
        ),
      );

      final mockResponse = Response(
        requestOptions: RequestOptions(path: testPath),
        data: jsonMap,
        statusCode: 200,
      );

      /// Arrange
      when(mockDioClient.getRequest(path: testPath))
          .thenAnswer((_) => Future.value(mockResponse)); 

      /// Act
      final result =
          await weatherApiSourceImpl.getCurrentWeather(location, aqi);

      /// Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right, but got Left with failure: $failure'),
        (weather) {
          expect(weather, isA<WeatherModel>());
        },
      );
      verify(mockDioClient.getRequest(path: testPath)).called(1);
    });

    test("should returns ServerException for other Dio errors", () async{
      /// Arrange
      when(mockDioClient.getRequest(path: testPath)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: testPath),
        ),
      );

      /// Act
      final result = await weatherApiSourceImpl.getCurrentWeather(location, aqi);

      /// Assert
      expect(result.isLeft(), true);
      result.fold(
        (error){
          expect(error, isA<ServerException>());
          expect(error.message, "Failed to fetch weather details");
        }, 
        (_)=> fail("Expected Left, got Right"),
      );
      verify(mockDioClient.getRequest(path: testPath)).called(1);

    });
  });
}
