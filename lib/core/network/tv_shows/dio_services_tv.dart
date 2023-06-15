import 'package:dio/dio.dart';

import '../dio_network.dart';

class DioServicesTV {
  Future<Response> getTopRatedTV(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getOnTheAirTV(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getAiringTV(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getPopularTV(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }
}
