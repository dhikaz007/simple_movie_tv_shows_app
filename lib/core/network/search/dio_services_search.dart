import 'package:dio/dio.dart';
import '../dio_network.dart';

class DioServicesSearch {
  Future<Response> getSearch(String endpoint, {required String query}) async {
    final response = await DioNetwork.dio.get(
      endpoint,
      queryParameters: {'query': query},
    );
    return response;
  }
}
