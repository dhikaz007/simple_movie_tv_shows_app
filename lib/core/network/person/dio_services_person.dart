import 'package:dio/dio.dart';

import '../dio_network.dart';

class DioServicesPeople {
  Future<Response> getPeople(String endpoint) async {
    final response = await DioNetwork.dio.get(endpoint);
    return response;
  }
}
