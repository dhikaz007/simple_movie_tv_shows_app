part of 'widgets.dart';

class GenreChip extends StatelessWidget {
  final List<Genres> listGenre;
  const GenreChip({super.key, required this.listGenre});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 32),
      child: ListView.separated(
        itemCount: listGenre.take(5).length,
        separatorBuilder: (context, index) => const Gap(12),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final genre = listGenre[index];
          return Chip(
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: AppColor.white,
            elevation: 0,
            label: AppText(
              text: genre.name ?? '-',
              size: FontAppSize.font_12,
              color: AppColor.red,
              weight: FontAppWeight.medium,
            ),
          );
        },
      ),
    );
  }
}

class GenresShimmer extends StatelessWidget {
  const GenresShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 32,
      ),
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const Gap(12),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const RectangleShimmer(
            w: 80,
            r: 30,
          );
        },
      ),
    );
  }
}
