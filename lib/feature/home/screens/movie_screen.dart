part of 'screens.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // late Future<ResponseAPI<GenresModel>> listGenres;
  // late Future<PaginationResponseAPI<ResultsModel>> listNowMovie;
  // late Future<PaginationResponseAPI<ResultsModel>> listPopularMovie;
  // late Future<PaginationResponseAPI<ResultsModel>> listTopRatedMovie;
  // late Future<PaginationResponseAPI<ResultsModel>> listUpcomingMovie;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.wait([
  //     listGenres = MovieServices().fetchGenres(),
  //     listNowMovie = MovieServices().fetchNowPlaying(1),
  //     listPopularMovie = MovieServices().fetchPopular(1),
  //     listTopRatedMovie = MovieServices().fetchTopRated(1),
  //     listUpcomingMovie = MovieServices().fetchUpcoming(1),
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      //   HeaderTitle(
      //     label: 'Discover Genres',
      //     onTap: () async {
      //       Modular.to.pushNamed('/movie/discover');
      //     },
      //   ),
      //   const Gap(12),
      //   GenreWidget(future: listGenres),
      //   const Gap(20),
      //   HeaderTitle(
      //     label: 'Now Playing',
      //     onTap: () {
      //       Modular.to.pushNamed('/movie/now-playing');
      //     },
      //   ),
      //   const Gap(12),
      //   MovieWidget(future: listNowMovie),
      //   const Gap(16),
      //   HeaderTitle(
      //     label: 'Popular',
      //     onTap: () {
      //       Modular.to.pushNamed('/movie/popular');
      //     },
      //   ),
      //   const Gap(12),
      //   MovieWidget(future: listPopularMovie),
      //   const Gap(16),
      //   HeaderTitle(
      //     label: 'Top Rated',
      //     onTap: () {
      //       Modular.to.pushNamed('/movie/top-rated');
      //     },
      //   ),
      //   const Gap(12),
      //   MovieWidget(future: listTopRatedMovie),
      //   const Gap(16),
      //   HeaderTitle(
      //     label: 'Upcoming',
      //     onTap: () {
      //       Modular.to.pushNamed('/movie/upcoming');
      //     },
      //   ),
      //   const Gap(12),
      //   MovieWidget(future: listUpcomingMovie),
      // ],
    
    );
  }
}
