import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/people_repository.dart';
import '../view_model/person_view_model.dart';
import 'person_home_page.dart';

class PersonHomeMain extends StatelessWidget {
  const PersonHomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonViewModel(
        peopleRepository: PeopleRepositoryImpl(),
      )..showPopularPeople(context),
      child: const PersonHomePage(),
    );
  }
}
