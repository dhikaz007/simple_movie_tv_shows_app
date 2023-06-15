import 'package:simple_movie_tv_shows_app/core/network/tv_shows/dio_services_tv.dart';

import '../../core/network/api_endpoint.dart';
import '../model/tv_model.dart';

abstract class TVRepository {
  Future<List<TVResult>?> loadTopRatedTV();
  Future<List<TVResult>?> loadOnTheAirTV();
  Future<List<TVResult>?> loadAiringTV();
  Future<List<TVResult>?> loadPopularTV();
}

class TVRepositoryImpl extends TVRepository {
  @override
  Future<List<TVResult>?> loadAiringTV() async {
    final json = await DioServicesTV()
        .getAiringTV('${ApiEndpoint.tv}${ApiEndpoint.airingToday}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResult>?> loadPopularTV() async {
    final json = await DioServicesTV().getPopularTV('${ApiEndpoint.tv}${ApiEndpoint.popular}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResult>?> loadTopRatedTV() async {
    final json = await DioServicesTV().getTopRatedTV('${ApiEndpoint.tv}${ApiEndpoint.topRated}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }

  @override
  Future<List<TVResult>?> loadOnTheAirTV() async {
    final json = await DioServicesTV().getOnTheAirTV('${ApiEndpoint.tv}${ApiEndpoint.onTheAir}');
    if (json.statusCode == 200) {
      final data = TVModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }
}
