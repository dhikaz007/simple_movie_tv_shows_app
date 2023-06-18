import 'package:dio/dio.dart';

import '../dio_network.dart';

class DioServicesMovie {
  Future<Response> getTopRatedMovie({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getUpcomingMovie({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getNowPlayingMovie({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getPopularMovie({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }
}
