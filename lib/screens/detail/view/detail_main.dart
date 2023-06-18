import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/movie_model.dart';
import '../../../repositories/movie_repository.dart';
import '../../favorite/view_model/favorite_view_model.dart';
import 'detail_page.dart';

class DetailMain extends StatelessWidget {
  final String movieBackdrop;
  final String movieTitle;
  final double movieRating;
  final DateTime movieReleaseData;
  final String movieOverview;
  final MovieResults? result;
  const DetailMain({
    super.key,
    required this.movieBackdrop,
    required this.movieTitle,
    required this.movieRating,
    required this.movieReleaseData,
    required this.movieOverview,
    this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel(
        movieRepository: MovieRepositoryImpl(),
      ),
      child: DetailPage(
        movieBackdrop: movieBackdrop,
        movieTitle: movieTitle,
        movieRating: movieRating,
        movieReleaseData: movieReleaseData,
        movieOverview: movieOverview,
        result: result,
      ),
    );
  }
}
