import 'package:dio/dio.dart';

import '../dio_network.dart';

class DioServicesTV {
  Future<Response> getTopRatedTV({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getOnTheAirTV({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getAiringTV({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }

  Future<Response> getPopularTV({required String endpoint}) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }
}
