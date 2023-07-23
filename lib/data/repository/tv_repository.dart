import '../../core/network/api_endpoint.dart';
import '../../core/network/search/dio_services_search.dart';
import '../../core/network/tv_shows/dio_services_tv.dart';
import '../model/search_tv_model.dart';
import '../model/tv_model.dart';

abstract class TVRepository {
  Future<List<TVResult>?> loadTopRatedTV();
  Future<List<TVResult>?> loadOnTheAirTV();
  Future<List<TVResult>?> loadAiringTV();
  Future<List<TVResult>?> loadPopularTV();
  Future<List<SearchTVResult>?> loadSearchTV({required String query});
}

class TVRepositoryImpl extends TVRepository {
  @override
  Future<List<TVResult>?> loadAiringTV() async {
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
  Future<List<TVResult>?> loadPopularTV() async {
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
  Future<List<TVResult>?> loadTopRatedTV() async {
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
  Future<List<TVResult>?> loadOnTheAirTV() async {
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
  Future<List<SearchTVResult>?> loadSearchTV({required String query}) async {
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
