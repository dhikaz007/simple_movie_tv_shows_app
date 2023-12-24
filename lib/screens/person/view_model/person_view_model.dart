// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../models/people_model.dart';
import '../../../repositories/people_repository.dart';

class PersonViewModel extends ChangeNotifier {
  final PeopleRepository peopleRepository;

  PersonViewModel({required this.peopleRepository});

  List<PeopleResults>? _peopleResult = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<PeopleResults>? get peopleResult => _peopleResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> showPopularPeople(BuildContext context) async {
    _isLoading = true;
    try {
      _peopleResult = await peopleRepository.loadPopularPeople();
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(
            '$e',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
