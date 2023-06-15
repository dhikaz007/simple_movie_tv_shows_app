import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/app_radius.dart';
import '../../../../utils/constant/app_spacing.dart';

class SearchResultWidget extends StatelessWidget {
  final String moviePoster;
  final String movieTitle;
  final double movieRating;
  final String movieOverview;
  final VoidCallback? onPressed;
  const SearchResultWidget({
    super.key,
    required this.moviePoster,
    required this.movieTitle,
    required this.movieRating,
    required this.movieOverview,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.space12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppRadius.radius12,
            ),
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width / 2.4,
              height: MediaQuery.of(context).size.height / 3.2,
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
              imageUrl: 'https://image.tmdb.org/t/p/original$moviePoster',
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.4,
            height: MediaQuery.of(context).size.height / 3.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColor.primaryWhite,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppSpacing.space12),
                Text.rich(
                  TextSpan(
                    text: 'TMDB ',
                    children: [
                      TextSpan(
                        text: '$movieRating',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColor.primaryWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColor.goldenBuddhaBelly,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: AppSpacing.space12),
                Text(
                  movieOverview,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColor.primaryWhite,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: onPressed,
                    icon: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColor.primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
