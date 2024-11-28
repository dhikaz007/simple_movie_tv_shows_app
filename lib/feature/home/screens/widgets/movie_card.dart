part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double vote;
  final String poster;
  const MovieCard({
    super.key,
    required this.title,
    required this.date,
    required this.vote,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            constraints: const BoxConstraints(
              maxWidth: 140,
              maxHeight: 220,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedImage(
                      imageUrl: '${UrlConstant.baseUrlImageOriginal}$poster'),
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
                          text: '$vote',
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
          const Gap(4),
          AppText(
            text: title,
            size: FontAppSize.font_14,
            weight: FontAppWeight.medium,
            overflow: TextOverflow.ellipsis,
            color: AppColor.white,
          ),
          const Gap(4),
          AppText(
            text: 'Release: ${DateFormat('dd MMM y').format(date)}',
            size: FontAppSize.font_12,
            color: AppColor.white,
          ),
        ],
      ),
    );
  }
}
