import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/movie_repository.dart';
import '../view_model/now_playing_movie_view_model.dart';
import '../view_model/popular_movie_view_model.dart';
import '../view_model/top_rated_movie_view_model.dart';
import '../view_model/upcoming_movie_view_model.dart';
import 'home_page.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TopRatedMovieViewModel(
            movieRepository: MovieRepositoryImpl(),
          )..showTopRatedMovie(context),
        ),
        ChangeNotifierProvider(
          create: (context) => UpcomingMovieViewModel(
            movieRepository: MovieRepositoryImpl(),
          )..showUpcomingMovie(context),
        ),
        ChangeNotifierProvider(
          create: (context) => NowPlayingMovieViewModel(
            movieRepository: MovieRepositoryImpl(),
          )..showNowPlayingMovie(context),
        ),
        ChangeNotifierProvider(
          create: (context) => PopularMovieViewModel(
            movieRepository: MovieRepositoryImpl(),
          )..showPopularMovie(context),
        ),
      ],
      child: const HomePage(),
    );
  }
}
