import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;
  late BaseOptions baseOptions;

  DioClient()
      : dio = Dio(
          BaseOptions(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            sendTimeout: const Duration(seconds: 30),
          ),
        );

  Future<Response> getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
