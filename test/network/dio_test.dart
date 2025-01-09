import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_api/core/network/dio.dart';

import '../modules/home/mock/mock.mocks.dart';

void main() {
  late DioClient dioClient;
  /// We use mockDio to simulate the Dio behaviour
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient();

    /// Injecting the mock dio
    dioClient.dio = mockDio;
  });

  group("DioClient getRequest", () {
    test("returns response on a successful request", () async {
      const testPath = '/test';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: testPath),
        data: {'key': 'value'},
        statusCode: 200,
      );

      /// Arrange
      when(mockDio.get(
        testPath,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => mockResponse);

      /// Act
      final response = await dioClient.getRequest(path: testPath);

      /// Assert
      expect(response.data, {'key': 'value'});
      expect(response.statusCode, 200);
      verify(mockDio.get(
        testPath,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).called(1);
      /// Above statement ensures the get method was called exactly 
      /// once during the test execution
    });

    test("throws DioException on error", () async{
      const testPath = '/test';
      /// Arrange
      when(mockDio.get(
        testPath,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenThrow(DioException(requestOptions: RequestOptions(path: testPath)));

      /// Assert
      expect(() async => await dioClient.getRequest(path: testPath), throwsA(isA<DioException>()));
    });
  });
}
