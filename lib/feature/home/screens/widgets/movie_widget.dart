part of 'widgets.dart';

class MovieWidget extends StatelessWidget {
  final Future<dynamic>? future;
  const MovieWidget({super.key, this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 280),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) => const MovieCardShimmer(),
            ),
          );
        } else if (snapshot.hasData) {
          return ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 280),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.data?.results.length ?? 0,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final movie = snapshot.data?.results[index];
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('/movie/detail', arguments: movie);
                  },
                  child: MovieCard(
                    title: movie?.title ?? '-',
                    date: movie?.releaseDate ?? DateTime.now(),
                    vote: movie?.voteAverage ?? 0.0,
                    poster: movie?.posterPath ?? '-',
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
