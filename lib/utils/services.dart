part of 'utils.dart';

mixin Services {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: UrlConstant.baseUrl,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  );

  Future<Dio> dio() async {
    Dio dio = Dio(_baseOptions);

    final sessionId = await LocalStorage.getSessionId();

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        compact: false,
      ),
      InterceptorsWrapper(
        onRequest: (request, handler) {
          request.headers['Authorization'] =
              'Bearer ${dotenv.env['TMDB_TOKEN_KEY']}';
          if (sessionId != null && sessionId.isNotEmpty) {
            request.queryParameters['session_id'] = sessionId;
          }
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
