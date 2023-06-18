import 'package:dio/dio.dart';

class DioNetwork {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const Map<String, dynamic> headers = {
    'Content-Type': 'aplication/json'
  };

  static const Map<String, dynamic> queryParam = {
    'api_key': 'd4a328f844e5cb3565bb9935e65101bc',
    'language': 'en-US',
    'page': 1
  };

  static final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      queryParameters: queryParam,
      headers: headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
}
