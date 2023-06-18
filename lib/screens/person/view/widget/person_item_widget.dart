import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/app_radius.dart';
import '../../../../utils/constant/app_spacing.dart';

class PersonItemWidget extends StatelessWidget {
  final String moviePoster;
  final String? movieTitle;
  final double? movieRating;
  final GestureTapCallback? onTap;
  const PersonItemWidget({
    super.key,
    required this.moviePoster,
    this.movieTitle,
    this.movieRating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.space16),
      child: SizedBox(
        width: 136,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.radius12),
                child: CachedNetworkImage(
                  height: 200,
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              movieTitle ?? '',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColor.primaryWhite,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text.rich(
              TextSpan(
                text: 'TMDB ',
                children: [
                  TextSpan(
                    text: '$movieRating',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColor.primaryWhite,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColor.goldenBuddhaBelly,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
