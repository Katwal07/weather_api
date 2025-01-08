import 'package:dio/dio.dart';
import 'package:weather_app_api/core/network/api_const.dart';

class DioClient {
  late Dio dio;
  late BaseOptions baseOptions;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstant.baseUrl,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            sendTimeout: const Duration(seconds: 30),
          ),
        );

  Future<Response> getRequest({required String path}) async {
    try {
      final Response response = await dio.get(path);
      return response;
    } on DioException {
      rethrow;
    }
  }
}
