part of 'widgets.dart';

class SearchCardWidget extends StatelessWidget {
  final ResultsModel movie;
  final VoidCallback? onPressed;
  const SearchCardWidget({super.key, required this.movie, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              color: AppColor.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: movie.posterPath == null
                      ? const SizedBox.shrink()
                      : CachedImage(
                          imageUrl:
                              '${UrlConstant.baseUrlImage500}${movie.posterPath}'),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        AppText(
                          text: '${movie.voteAverage}',
                          size: FontAppSize.font_12,
                          color: AppColor.black,
                        ),
                        const Gap(4),
                        const Icon(
                          Icons.star,
                          color: AppColor.yellowGold,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: movie.originalTitle ?? '-',
                  size: FontAppSize.font_14,
                  color: AppColor.white,
                  weight: FontAppWeight.medium,
                ),
                const Gap(4),
                AppText(
                  text: movie.releaseDate != null
                      ? 'Release Date: ${DateFormat('dd MMMM y').format(movie.releaseDate ?? DateTime.now())}'
                      : 'Release Date: -',
                  size: FontAppSize.font_12,
                  color: AppColor.white,
                ),
                const Gap(4),
                AppText(
                  text: 'Vote Count: ${movie.voteCount}',
                  size: FontAppSize.font_12,
                  color: AppColor.white,
                ),
                const Gap(4),
                AppText(
                  text: 'Popularity: ${movie.popularity}',
                  size: FontAppSize.font_12,
                  color: AppColor.white,
                ),
                const Gap(8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: onPressed,
                    style:
                        const ButtonStyle(visualDensity: VisualDensity.compact),
                    icon: const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.white,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColor.black,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColor.white,
                          size: 14,
                        ),
                      ),
                    ),
                    label: const AppText(
                      text: 'See Detail',
                      size: FontAppSize.font_12,
                      color: AppColor.white,
                      weight: FontAppWeight.medium,
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
