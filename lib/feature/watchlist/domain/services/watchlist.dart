part of 'services.dart';

sealed class WatchlistRepository {
  Future<PaginationResponseAPI<ResultsModel>> fetchWatchList({
    int? page,
    String? order,
  });
  Future<ResponseAPI<WatchListModel>> postWatchList({required int movieId});
}

final class WatchlistServices with Services implements WatchlistRepository {
  @override
  Future<ResponseAPI<WatchListModel>> postWatchList(
      {required int movieId}) async {
    try {
      Dio http = await dio();

      final sessionId = await LocalStorage.getSessionId();
      final box = Boxes.getProfileValue();
      final accountId = box.id;

      final params = {
        "media_type": "movie",
        "media_id": 11,
        "watchlist": true,
        "session_id": sessionId,
      };

      Response response = await http.post(
        '/account/$accountId/watchlist',
        queryParameters: params,
      );

      final data = response.data;

      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchWatchList(
      {int? page, String? order}) async {
    try {
      Dio http = await dio();

      final sessionId = await LocalStorage.getSessionId();
      final box = Boxes.getProfileValue();
      final accountId = box.id;

      final params = {
        "page": page,
        "language": "en-US",
        "sort_by": order ?? "created_at.asc",
        "session_id": sessionId,
      };

      Response response = await http.get(
        '/account/$accountId/watchlist/movies',
        queryParameters: params,
      );

      final data = response.data;
      if (response.statusCode == 200) {
        data['results'] = (data['results'] as List)
            .map((e) => ResultsModel.fromJson(e))
            .toList();
        LoggerHelper.info(data['results'].toString());
        return PaginationResponseAPI<ResultsModel>.fromJson(data);
      }

      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }
}
