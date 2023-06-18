import 'package:flutter/material.dart';

import '../../../models/movie_model.dart';
import '../../../repositories/movie_repository.dart';

class NowPlayingMovieViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;

  NowPlayingMovieViewModel({required this.movieRepository});

  List<MovieResults> _movieResult = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<MovieResults> get movieResult => _movieResult;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> showNowPlayingMovie(BuildContext context) async {
    _isLoading = true;
    try {
      _movieResult = await movieRepository.loadNowPlayingMovie();
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