part of 'screens.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ValueNotifier<List<Genres>> _listGenre = ValueNotifier([]);
  final ValueNotifier<bool> _loadingGenre = ValueNotifier(true);
  final ValueNotifier<List<ResultsModel>> _listNowMovie = ValueNotifier([]);
  final ValueNotifier<bool> _loadingNowMovie = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _listGenre.dispose();
    _loadingGenre.dispose();
    _loadingNowMovie.dispose();
    _listNowMovie.dispose();
    super.dispose();
  }

  void initialize() async {
    final completer = Completer<void>();
    await Future.wait([
      _loadGenres(),
      _loadNowPlayingMovie(),
    ]).then((_) => completer.complete());

    await completer.future;
  }

  Future<void> _loadGenres() async {
    try {
      _loadingGenre.value = true;
      final response = await MovieServices().fetchGenres();
      _listGenre.value = response.data?.genres ?? [];
    } on DioException catch (e) {
      if (!mounted) return;
      AppDialog.showSnackbar(context, e.msgDioErr(), SnackBarStatus.failure);
    } finally {
      _loadingGenre.value = false;
    }
  }

  Future<void> _loadNowPlayingMovie() async {
    try {
      _loadingNowMovie.value = true;
      final response = await MovieServices().fetchNowPlaying(1);
      _listNowMovie.value = response.results ?? [];
    } on DioException catch (e) {
      if (!mounted) return;
      AppDialog.showSnackbar(context, e.msgDioErr(), SnackBarStatus.failure);
    } finally {
      _loadingNowMovie.value = false;
    }
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
        ValueListenableBuilder(
          valueListenable: _loadingGenre,
          builder: (context, value, child) {
            if (value == true) {
              return child!;
            } else {
              return ValueListenableBuilder(
                valueListenable: _listGenre,
                builder: (context, value, child) => child!,
                child: Container(
                  constraints: const BoxConstraints.expand(
                    height: 32,
                  ),
                  child: ListView.separated(
                    itemCount: _listGenre.value.take(5).length,
                    separatorBuilder: (context, index) => const Gap(12),
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final genre = _listGenre.value[index];
                      return ActionChip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          print('${genre.id}');
                        },
                        label: AppText(
                            text: genre.name ?? '-',
                            size: FontAppSize.font_12,
                            color: AppColor.black),
                      );
                    },
                  ),
                ),
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        const Gap(20),
        HeaderTitle(
          label: 'Now Playing',
          onTap: () {},
        ),
        const Gap(12),
        ValueListenableBuilder(
          valueListenable: _loadingNowMovie,
          builder: (context, loadingNowMovie, child) {
            if (loadingNowMovie == true) {
              return child!;
            } else {
              return ValueListenableBuilder(
                valueListenable: _listNowMovie,
                builder: (context, nowMovie, child) => nowMovie.isEmpty
                    ? const Center(
                        child: AppText(
                          text: 'Data Empty',
                          size: FontAppSize.font_14,
                          color: AppColor.black,
                        ),
                      )
                    : child!,
                child: Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _listNowMovie.value.length,
                    separatorBuilder: (context, index) => const Gap(12),
                    itemBuilder: (context, index) {
                      final nowMovie = _listNowMovie.value[index];
                      return GestureDetector(
                        onTap: () {
                          Modular.to
                              .pushNamed('/movie/detail', arguments: nowMovie);
                        },
                        child: MovieCard(
                          title: nowMovie.originalTitle ?? '-',
                          date: nowMovie.releaseDate ?? DateTime.now(),
                          vote: nowMovie.voteAverage ?? 0.0,
                          poster: nowMovie.posterPath ?? '-',
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColor.red,
            ),
          ),
        )
      ],
    );
  }
}
