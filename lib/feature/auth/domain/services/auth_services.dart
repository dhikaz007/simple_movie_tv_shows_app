part of 'services.dart';

sealed class AuthRepository {
  Future<void> fetchToken();
  Future<ResponseAPI<TokenResponse>> fetchLogin({
    required String username,
    required String password,
  });
  Future<ResponseAPI<SessionModel>> fetchSession();
  Future<ResponseAPI<bool>> fetchLogout();
}

final class AuthServices with Services implements AuthRepository {
  @override
  Future<void> fetchToken() async {
    try {
      Dio http = await dio();

      Response response = await http.get('/authentication/token/new');

      final data = response.data;
      if (response.statusCode == 200) {
        final datas = TokenResponse.fromJson(data);
        await LocalStorage.setAccessToken(token: datas.requestToken ?? '-');
        print('INI DATA');
        print(datas);
        print('SAMPE SINI');
      }
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }

  @override
  Future<ResponseAPI<TokenResponse>> fetchLogin({
    required String username,
    required String password,
  }) async {
    try {
      Dio http = await dio();

      final token = await LocalStorage.getAccessToken();

      Response response = await http.post(
        '/authentication/token/validate_with_login',
        data: {
          "username": username,
          "password": password,
          "request_token": token,
        },
      );

      final data = response.data;
      if (response.statusCode == 200) {
        final datas = TokenResponse.fromJson(data);
        print('INI DATA');
        print(datas);
        print('SAMPE SINI');
        return ResponseAPI.fromJson(datas);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }

  @override
  Future<ResponseAPI<SessionModel>> fetchSession() async {
    try {
      Dio http = await dio();

      final token = await LocalStorage.getAccessToken();

      Response response = await http.post(
        '/authentication/session/new',
        data: {"request_token": token},
      );

      final data = response.data;
      if (response.statusCode == 200) {
        final datas = SessionModel.fromJson(data);
        print('INI DATA');
        print(datas);
        print('SAMPE SINI');
        return ResponseAPI.fromJson(datas);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }

  @override
  Future<ResponseAPI<bool>> fetchLogout() async {
    try {
      Dio http = await dio();

      final sessionId = await LocalStorage.getSessionId();

      Response response = await http.delete(
        '/authentication/session',
        data: {"session_id": sessionId},
      );

      final data = response.data;
      if (response.statusCode == 200) {
        final datas =
            ResponseAPI.fromJson(data['success'] as bool);
        return datas;
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }
}
