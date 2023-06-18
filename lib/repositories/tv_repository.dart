import '../models/search_tv_model.dart';
import '../models/tv_model.dart';
import '../services/api_endpoint.dart';
import '../services/search/dio_services_search.dart';
import '../services/tv_shows/dio_services_tv.dart';

abstract class TVRepository {
  Future<List<TVResults>?> loadTopRatedTV();
  Future<List<TVResults>?> loadOnTheAirTV();
  Future<List<TVResults>?> loadAiringTV();
  Future<List<TVResults>?> loadPopularTV();
  Future<List<SearchTVResults>?> loadSearchTV({required String query});
}

class TVRepositoryImpl extends TVRepository {
  @override
  Future<List<TVResults>?> loadAiringTV() async {
    final json = await DioServicesTV()
        .getAiringTV(endpoint: '${ApiEndpoint.tv}${ApiEndpoint.airingToday}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResults>?> loadPopularTV() async {
    final json = await DioServicesTV()
        .getPopularTV(endpoint: '${ApiEndpoint.tv}${ApiEndpoint.popular}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResults>?> loadTopRatedTV() async {
    final json = await DioServicesTV()
        .getTopRatedTV(endpoint: '${ApiEndpoint.tv}${ApiEndpoint.topRated}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResults>?> loadOnTheAirTV() async {
    final json = await DioServicesTV()
        .getOnTheAirTV(endpoint: '${ApiEndpoint.tv}${ApiEndpoint.onTheAir}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<SearchTVResults>?> loadSearchTV({required String query}) async {
    final json = await DioServicesSearch().getSearch(
      endpoint: '${ApiEndpoint.search}${ApiEndpoint.tv}',
      query: query,
    );
    if (json.statusCode == 200) {
      final data = SearchTVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }
}
