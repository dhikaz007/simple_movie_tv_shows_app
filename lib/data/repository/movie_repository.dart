import '../../core/network/search/dio_services_search_movie.dart';
import '../../core/network/api_endpoint.dart';
import '../../core/network/movies/dio_services_movie.dart';
import '../model/movie_model.dart';
import '../model/search_movie_model.dart';

abstract class MovieRepository {
  Future<List<Result>> loadTopRatedMovie();
  Future<List<Result>> loadUpcomingMovie();
  Future<List<Result>> loadNowPlayingMovie();
  Future<List<Result>> loadPopularMovie();
  Future<List<SearchResults>?> loadSearchMovie({required String query});
}

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<List<Result>> loadNowPlayingMovie() async {
    final json = await DioServicesMovie()
        .getNowPlayingMovie(ApiEndpoint.nowPlayingMovie);
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<Result>> loadPopularMovie() async {
    final json =
        await DioServicesMovie().getPopularMovie(ApiEndpoint.popularMovie);
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<Result>> loadTopRatedMovie() async {
    final json =
        await DioServicesMovie().getTopRatedMovie(ApiEndpoint.topRatedMovie);
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<Result>> loadUpcomingMovie() async {
    final json =
        await DioServicesMovie().getUpcomingMovie(ApiEndpoint.upcomingMovie);
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<SearchResults>?> loadSearchMovie({required String query}) async {
    final json = await DioServicesSearchMovie().getSearchMovie(
      ApiEndpoint.movie,
      query: query,
    );
    if (json.statusCode == 200) {
      final data = SearchMovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }
}
