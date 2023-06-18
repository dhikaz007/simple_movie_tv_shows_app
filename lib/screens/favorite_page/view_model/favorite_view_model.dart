import 'package:flutter/material.dart';

import '../../../models/movie_model.dart';
import '../../../repositories/movie_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;

  FavoriteViewModel({required this.movieRepository});

  final List<MovieResults> _myList = [];

  List<MovieResults> get myList => _myList;

  addToFavorite(MovieResults result) {
    _myList.add(result);
    notifyListeners();
  }

  removeFromFavorite(MovieResults result) {
    _myList.remove(result);
    notifyListeners();
  }
}
