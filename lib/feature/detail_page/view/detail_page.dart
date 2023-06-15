import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_tv_shows_app/feature/favorite_page/view_model/favorite_view_model.dart';

import '../../../data/model/movie_model.dart';
import '../../../utils/constant/app_radius.dart';
import '../../../utils/constant/app_spacing.dart';
import '../../../utils/widget/app_scaffold.dart';
import '../../../utils/constant/app_color.dart';

class DetailPage extends StatelessWidget {
  final String movieBackdrop;
  final String movieTitle;
  final double movieRating;
  final DateTime movieReleaseData;
  final String movieOverview;
  final Result? result;
  const DetailPage({
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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColor.blacklist,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.radius32),
              bottomRight: Radius.circular(AppRadius.radius32),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.goldenBuddhaBelly,
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'NO IMAGE',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColor.goldenBuddhaBelly,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                );
              },
              imageUrl: 'https://image.tmdb.org/t/p/original$movieBackdrop',
            ),
          ),
        ),
        AppScaffold(
          isAppbar: AppBarVisibility.off,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space20,
                vertical: AppSpacing.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColor.primaryWhite,
                          ),
                        ),
                        Consumer<FavoriteViewModel>(
                          builder: (context, favoriteValue, _) {
                            return InkWell(
                              onTap: () {
                                // if (!favoriteValue.myList.contains(result)) {
                                //   favoriteValue.addToFavorite(result!);
                                // } else {
                                //   favoriteValue.removeFromFavorite(result!);
                                // }
                              },
                              child: Icon(
                                favoriteValue.myList.contains(result)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: AppColor.primaryWhite,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space224),
                  Text(
                    movieTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColor.primaryWhite,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'TMDB ',
                      children: [
                        TextSpan(
                          text: '$movieRating',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColor.primaryWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.goldenBuddhaBelly,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    '${movieReleaseData.year}-${movieReleaseData.month}-${movieReleaseData.day}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.primaryWhite,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.space60),
                  Text(
                    'Movie Info',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColor.goldenBuddhaBelly,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    movieOverview,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColor.primaryWhite,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
