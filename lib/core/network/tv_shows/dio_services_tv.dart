import 'package:dio/dio.dart';

class DioServicesTV {
  static const String baseUrlTV = 'https://api.themoviedb.org/3/tv';

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
      baseUrl: baseUrlTV,
      queryParameters: queryParam,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<Response> getTopRatedTV(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response;
  }

  Future<Response> getOnTheAirTV(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response;
  }

  Future<Response> getAiringTV(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response;
  }

  Future<Response> getPopularTV(String endpoint) async {
    final response = await _dio.get(endpoint);
    return response;
  }
}
