import '../models/people_model.dart';
import '../services/api_endpoint.dart';
import '../services/person/dio_services_person.dart';

abstract class PeopleRepository {
  Future<List<PeopleResults>?> loadPopularPeople();
}

class PeopleRepositoryImpl extends PeopleRepository {
  @override
  Future<List<PeopleResults>?> loadPopularPeople() async {
    final json = await DioServicesPeople()
        .getPeople(endpoint: '${ApiEndpoint.person}${ApiEndpoint.popular}');
    if (json.statusCode == 200) {
      final data = PeopleModel.fromJson(json.data);
      return data.results;
    } else {
      return [];
    }
  }
}
