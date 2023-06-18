import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/movie_repository.dart';
import '../view_model/favorite_view_model.dart';
import 'favorite_page.dart';

class FavoriteMain extends StatelessWidget {
  const FavoriteMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel(
        movieRepository: MovieRepositoryImpl(),
      ),
      child: const FavoritePage(),
    );
  }
}
