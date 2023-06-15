import 'package:flutter/material.dart';

import '../../../data/model/movie_model.dart';
import '../../../data/repository/movie_repository.dart';

class PopularMovieViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;

  PopularMovieViewModel({required this.movieRepository});

  List<Result> _movieResult = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Result> get movieResult => _movieResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> showPopularMovie(BuildContext context) async {
    _isLoading = true;
    try {
      _movieResult = await movieRepository.loadPopularMovie();
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
