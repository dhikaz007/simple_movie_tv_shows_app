import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/movie_repository.dart';
import '../view_model/search_movie_view_model.dart';
import 'search_movie_page.dart';

class SearchMovieMain extends StatelessWidget {
  const SearchMovieMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchMovieViewModel(
        movieRepository: MovieRepositoryImpl(),
      ),
      child: const SearchMoviePage(),
    );
  }
}
