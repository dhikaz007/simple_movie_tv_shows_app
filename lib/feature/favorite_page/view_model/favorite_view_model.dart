import 'package:flutter/material.dart';

import '../../../data/repository/movie_repository.dart';
import '../../../data/model/movie_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;

  FavoriteViewModel({required this.movieRepository});

  final List<Result> _myList = [];

  List<Result> get myList => _myList;

  addToFavorite(Result result) {
    _myList.add(result);
    notifyListeners();
  }

  removeFromFavorite(Result result) {
    _myList.remove(result);
    notifyListeners();
  }
}
