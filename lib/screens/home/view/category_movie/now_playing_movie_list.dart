import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../detail/view/detail_main.dart';
import '../../view_model/now_playing_movie_view_model.dart';
import '../widget/movie_item_widget.dart';

class NowPlayingMovieList extends StatelessWidget {
  const NowPlayingMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingMovieViewModel>(
      builder: (context, movieValue, child) {
        if (movieValue.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.goldenBuddhaBelly,
            ),
          );
        } else {
          return SizedBox(
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: movieValue.movieResult.length,
              itemBuilder: (context, index) {
                return MovieItemWidget(
                  moviePoster: movieValue.movieResult[index].posterPath,
                  movieTitle: movieValue.movieResult[index].title,
                  movieRating: movieValue.movieResult[index].voteAverage,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailMain(
                            movieBackdrop:
                                movieValue.movieResult[index].backdropPath,
                            movieTitle: movieValue.movieResult[index].title,
                            movieRating:
                                movieValue.movieResult[index].voteAverage,
                            movieReleaseData:
                                movieValue.movieResult[index].releaseDate,
                            movieOverview:
                                movieValue.movieResult[index].overview,
                                result: movieValue.movieResult[index],
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
