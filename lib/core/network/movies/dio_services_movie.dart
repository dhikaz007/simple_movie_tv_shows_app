import 'package:dio/dio.dart';

import '../dio_network.dart';

class DioServicesMovie {
  Future<Response> getTopRatedMovie(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getUpcomingMovie(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getNowPlayingMovie(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getPopularMovie(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }
}
