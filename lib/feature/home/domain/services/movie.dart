part of 'services.dart';

sealed class MovieRepository {
  Future<ResponseAPI<GenresModel>> fetchGenres();
  Future<PaginationResponseAPI<ResultsModel>> fetchNowPlaying(int? page);
}

final class MovieServices with Services implements MovieRepository {
  @override
  Future<ResponseAPI<GenresModel>> fetchGenres() async {
    try {
      Dio http = await dio();

      final params = {"language": "en"};

      Response response = await http.get(
        '/genre/movie/list',
        queryParameters: params,
      );

      final data = response.data;
      if (response.statusCode == 200) {
        final datas = GenresModel.fromJson(data);
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
  Future<PaginationResponseAPI<ResultsModel>> fetchNowPlaying(int? page) async {
    try {
      Dio http = await dio();

      final params = {
        "language": "en",
        "page": page,
        "region": "",
      };

      Response response = await http.get(
        '/movie/now_playing',
        queryParameters: params,
      );

      var data = response.data;
      if (response.statusCode == 200) {
        print('KESINI');
        data['results'] = (data['results'] as List)
            .map((e) => ResultsModel.fromJson(e))
            .toList();
        print('INI DATA');
        print(data);
        print('SAMPE SINI');
        return PaginationResponseAPI<ResultsModel>.fromJson(data);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      throw e.msgDioErr();
    }
  }
}
