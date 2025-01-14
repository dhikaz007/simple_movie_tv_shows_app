part of 'services.dart';

sealed class ListsRepository {
  Future<PaginationResponseAPI<ListsModel>> fetchLists(int? page);
}

final class ListsServices with Services implements ListsRepository {
  @override
  Future<PaginationResponseAPI<ListsModel>> fetchLists(int? page) async {
    try {
      Dio http = await dio();

      final box = Boxes.getProfileValue();
      final accountId = box.id;
      final sessionId = await LocalStorage.getSessionId();

      Response response = await http.get(
        '/account/$accountId/lists',
        queryParameters: {
          "page": page,
          "session_id": sessionId,
        },
      );

      final data = response.data;
      if (response.statusCode == 200) {
        data['results'] = (data['results'] as List)
            .map((e) => ListsModel.fromMap(e))
            .toList();
        LoggerHelper.info(data['results'].toString());
        return PaginationResponseAPI<ListsModel>.fromJson(data);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }
}
