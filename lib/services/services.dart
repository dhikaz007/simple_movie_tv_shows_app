import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constant/constant.dart';

part 'response_api.dart';

mixin Services {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: UrlConstant.baseUrl,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  );

  Future<Dio> dio() async {
    Dio dio = Dio(_baseOptions);

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        compact: false,
      ),
      InterceptorsWrapper(
        onRequest: (request, handler) {
          request.headers['Authorization'] = 'Bearer ${dotenv.env['TMDB_TOKEN_KEY']}';
          return handler.next(request);
        },
        // onResponse: (response, handler) {
        //   print('ON RESPONSE');
        //   print(response.toString());
        //   return handler.next(response);
        // },
        onError: (error, handler) {
          print('ON ERROR');
          print(error.response?.statusCode);

          return handler.next(error);
        },
      ),
    ]);

    return dio;
  }
}
