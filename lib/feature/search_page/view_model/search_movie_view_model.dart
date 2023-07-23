import 'package:flutter/material.dart';

import '../../../data/model/search_movie_model.dart';
import '../../../data/repository/movie_repository.dart';

class SearchMovieViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;

  SearchMovieViewModel({required this.movieRepository});

  List<SearchResults>? _movieResult = [];
  SearchResults? _movieListResult;
  String _querySearch = '';

  List<SearchResults>? get movieResult => _movieResult;
  SearchResults? get movieListResult => _movieListResult;
  String get querySearch => _querySearch;

  Future<void> showSearchMovie({required String query}) async {
    _movieResult = await movieRepository.loadSearchMovie(query: query);
    _querySearch = _movieResult
            ?.where(
              (element) =>
                  element.title?.toLowerCase().contains(query.toLowerCase()) ??
                  false,
            )
            .toList()
            .toString() ??
        '';
  }
}
