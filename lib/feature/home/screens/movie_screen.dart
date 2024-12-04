part of 'screens.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ScrollController npScroll = ScrollController();

  late Future<ResponseAPI<GenresModel>> listGenres;
  late Future<PaginationResponseAPI<ResultsModel>> listNowMovie;

  @override
  void initState() {
    super.initState();
    _loadGenres();
    _loadNowPlayingMovie();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ResponseAPI<GenresModel>> _loadGenres() {
    return listGenres = MovieServices().fetchGenres();
  }

  Future<PaginationResponseAPI<ResultsModel>> _loadNowPlayingMovie() async {
    return listNowMovie = MovieServices().fetchNowPlaying(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderTitle(
          label: 'Discover Genres',
          onTap: () async {
            Modular.to.pushNamed('/movie/discover');
          },
        ),
        const Gap(12),
        FutureBuilder(
          future: _loadGenres(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const GenresShimmer();
            } else if (snapshot.hasData) {
              return GenreWidget(listGenre: snapshot.data?.data?.genres ?? []);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const Gap(20),
        HeaderTitle(
          label: 'Now Playing',
          onTap: () {
            Modular.to.pushNamed('/movie/now-playing');
          },
        ),
        const Gap(12),
        FutureBuilder(
          future: _loadNowPlayingMovie(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Flexible(
                child: ListView.separated(
                  controller: npScroll,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) => const RectangleShimmer(
                    w: 140,
                    h: 270,
                    r: 10,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return Expanded(
                child: ListView.separated(
                  controller: npScroll,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data?.results?.length ?? 0,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    final nowMovie = snapshot.data?.results?[index];
                    return GestureDetector(
                      onTap: () {
                        Modular.to
                            .pushNamed('/movie/detail', arguments: nowMovie);
                      },
                      child: MovieCard(
                        title: nowMovie?.title ?? '-',
                        date: nowMovie?.releaseDate ?? DateTime.now(),
                        vote: nowMovie?.voteAverage ?? 0.0,
                        poster: nowMovie?.posterPath ?? '-',
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const Gap(20),
        HeaderTitle(
          label: 'Popular',
          onTap: () {
            Modular.to.pushNamed('/movie/popular');
          },
        ),
        const Gap(12),
      ],
    );
  }
}
