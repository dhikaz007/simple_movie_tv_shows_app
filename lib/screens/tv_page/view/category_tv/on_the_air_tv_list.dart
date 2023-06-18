import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../detail_page/view/detail_main.dart';
import '../../../home_page/view/widget/movie_item_widget.dart';
import '../../view_model/view_model.dart';

class OnTheAirTVList extends StatelessWidget {
  const OnTheAirTVList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnTheAirTVViewModel>(
      builder: (context, tvValue, child) {
        if (tvValue.isLoading) {
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
              itemCount: tvValue.tvResult?.length,
              itemBuilder: (context, index) {
                return MovieItemWidget(
                  moviePoster: tvValue.tvResult?[index].posterPath ?? '',
                  movieTitle: tvValue.tvResult?[index].name ?? '',
                  movieRating: tvValue.tvResult?[index].voteAverage ?? 0.0,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailMain(
                            movieBackdrop:
                                tvValue.tvResult?[index].backdropPath ?? '',
                            movieTitle: tvValue.tvResult?[index].name ?? '',
                            movieRating:
                                tvValue.tvResult?[index].voteAverage ?? 0.0,
                            movieReleaseData: DateTime.parse(
                                tvValue.tvResult?[index].firstAirDate ?? ''),
                            movieOverview:
                                tvValue.tvResult?[index].overview ?? '',
                            //result: tvValue.tvResult[index],
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
