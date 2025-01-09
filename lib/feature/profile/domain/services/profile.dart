part of 'services.dart';

sealed class ProfileRepository {
  Future<ResponseAPI<AccountModel>> fetchProfile();
}

final class ProfileServices with Services implements ProfileRepository {
  @override
  Future<ResponseAPI<AccountModel>> fetchProfile() async {
    try {
      Dio http = await dio();

      final sessionId = await LocalStorage.getSessionId();

      Response response = await http.get(
        '/account',
        queryParameters: {"session_id": sessionId},
      );

      final data = response.data;
      if (response.statusCode == 200) {
        final datas = AccountModel.fromJson(data);
        LoggerHelper.info(datas.toString());
        return ResponseAPI<AccountModel>.fromJson(datas);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }
}
