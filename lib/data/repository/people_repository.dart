import '../../core/network/api_endpoint.dart';
import '../../core/network/person/dio_services_person.dart';
import '../model/people_model.dart';

abstract class PeopleRepository {
  Future<List<PeopleResults>?> loadPopularPeople();
}

class PeopleRepositoryImpl extends PeopleRepository {
  @override
  Future<List<PeopleResults>?> loadPopularPeople() async {
    final json = await DioServicesPeople()
        .getPeople('${ApiEndpoint.person}${ApiEndpoint.popular}');
    if (json.statusCode == 200) {
      final data = PeopleModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }
}
