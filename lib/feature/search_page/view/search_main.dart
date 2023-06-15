import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/tv_repository.dart';
import '../view_model/search_tv_view_model.dart';
import '../../../data/repository/movie_repository.dart';
import '../view_model/search_movie_view_model.dart';
import 'search_page.dart';

class SearchMain extends StatelessWidget {
  const SearchMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SearchMovieViewModel(
            movieRepository: MovieRepositoryImpl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchTVViewModel(
            tvRepository: TVRepositoryImpl(),
          ),
        ),
      ],
      child: const SearchPage(),
    );
  }
}
