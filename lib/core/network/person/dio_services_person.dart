import 'package:dio/dio.dart';

class DioServicesPeople {
  static const String baseUrlPerson = 'https://api.themoviedb.org/3/person';

  static const Map<String, dynamic> headers = {
    'Content-Type': 'aplication/json'
  };

  static const Map<String, dynamic> queryParam = {
    'api_key': 'd4a328f844e5cb3565bb9935e65101bc',
    'language': 'en-US',
    'page': 1
  };

  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrlPerson,
      queryParameters: queryParam,
      headers: headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<Response> getPeople(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response;
  }
}
