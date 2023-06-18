import '../models/movie_model.dart';
import '../models/search_movie_model.dart';
import '../services/api_endpoint.dart';
import '../services/movies/dio_services_movie.dart';
import '../services/search/dio_services_search.dart';

abstract class MovieRepository {
  Future<List<MovieResults>> loadTopRatedMovie();
  Future<List<MovieResults>> loadUpcomingMovie();
  Future<List<MovieResults>> loadNowPlayingMovie();
  Future<List<MovieResults>> loadPopularMovie();
  Future<List<SearchMovieResults>?> loadSearchMovie({required String query});
}

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<List<MovieResults>> loadNowPlayingMovie() async {
    final json = await DioServicesMovie().getNowPlayingMovie(
        endpoint: '${ApiEndpoint.movie}${ApiEndpoint.nowPlaying}');
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<MovieResults>> loadPopularMovie() async {
    final json = await DioServicesMovie().getPopularMovie(
        endpoint: '${ApiEndpoint.movie}${ApiEndpoint.popular}');
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<MovieResults>> loadTopRatedMovie() async {
    final json = await DioServicesMovie().getTopRatedMovie(
        endpoint: '${ApiEndpoint.movie}${ApiEndpoint.topRated}');
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<MovieResults>> loadUpcomingMovie() async {
    final json = await DioServicesMovie().getUpcomingMovie(
        endpoint: '${ApiEndpoint.movie}${ApiEndpoint.upComing}');
    if (json.statusCode == 200) {
      final data = MovieModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<SearchMovieResults>?> loadSearchMovie({required String query}) async {
    final json = await DioServicesSearch().getSearch(
      endpoint: '${ApiEndpoint.search}${ApiEndpoint.movie}',
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
