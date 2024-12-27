part of 'routes.dart';

class MovieRoutes extends Module {
  @override
  void routes(r) {
    r.child('/discover', child: (_) => const DiscoverMovieScreen());
    r.child('/detail', child: (_) => MovieDetailScreen(movie: r.args.data));
    r.child(
      '/search',
      child: (_) => const SearchMovieScreen(),
      transition: TransitionType.downToUp,
    );
    r.child('/now-playing', child: (_) => const NowPlayingMovieScreen());
    r.child('/popular', child: (_) => const PopularMovieScreen());
    r.child('/top-rated', child: (_) => const TopRatedMovieScreen());
    r.child('/upcoming', child: (_) => const UpcomingMovieScreen());
  }
}
