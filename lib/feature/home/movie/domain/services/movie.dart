part of 'services.dart';

sealed class MovieRepository {
  Future<ResponseAPI<GenresModel>> fetchGenres();
  Future<PaginationResponseAPI<ResultsModel>> fetchNowPlaying(int? page);
  Future<PaginationResponseAPI<ResultsModel>> fetchPopular(int? page);
  Future<PaginationResponseAPI<ResultsModel>> fetchTopRated(int? page);
  Future<PaginationResponseAPI<ResultsModel>> fetchUpcoming(int? page);
  Future<PaginationResponseAPI<ResultsModel>> fetchSearch({
    required String query,
    int? page,
    bool? includeAdult = false,
    String? year,
  });
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
        LoggerHelper.info(datas.toString());
        return ResponseAPI.fromJson(datas);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchNowPlaying(int? page) async {
    try {
      Dio http = await dio();

      final deviceLocale = await LocalStorage.getRegion();

      final params = {
        "language": "en",
        "page": page,
        "region": deviceLocale,
      };

      Response response = await http.get(
        '/movie/now_playing',
        queryParameters: params,
      );

      var data = response.data;
      if (response.statusCode == 200) {
        data['results'] = (data['results'] as List)
            .map((e) => ResultsModel.fromJson(e))
            .toList();
        LoggerHelper.info(data['results'].toString());
        return PaginationResponseAPI<ResultsModel>.fromJson(data);
      }
      throw data['status_message'];
    } on DioException catch (e) {
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchPopular(int? page) async {
    try {
      Dio http = await dio();

      final region = await LocalStorage.getRegion();

      final params = {
        "language": "en_US",
        "page": page,
        "region": region,
      };

      Response response = await http.get(
        '/movie/popular',
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
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchTopRated(int? page) async {
    try {
      Dio http = await dio();

      final region = await LocalStorage.getRegion();

      final params = {
        "language": "en_US",
        "page": page,
        "region": region,
      };

      Response response = await http.get(
        '/movie/top_rated',
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
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchUpcoming(int? page) async {
    try {
      Dio http = await dio();

      final region = await LocalStorage.getRegion();

      final params = {
        "language": "en_US",
        "page": page,
        "region": region,
      };

      Response response = await http.get(
        '/movie/upcoming',
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
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }

  @override
  Future<PaginationResponseAPI<ResultsModel>> fetchSearch({
    required String query,
    int? page,
    bool? includeAdult = false,
    String? year,
  }) async {
    try {
      Dio http = await dio();

      final region = await LocalStorage.getRegion();

      final params = {
        "language": "en_US",
        "query": query,
        "page": page,
        "region": region,
        "year": year,
      };

      Response response = await http.get(
        '/search/movie',
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
      LoggerHelper.error(e.msgDioErr());
      throw e.msgDioErr();
    }
  }
}
